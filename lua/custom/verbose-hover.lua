local M = {}

---@class VerboseHoverState
---@field verbosity integer
---@field can_increase boolean
---@field requesting boolean
---@field generation integer
---@field source_bufnr integer|nil
---@field source_winid integer|nil
---@field source_pos { [1]: integer, [2]: integer }|nil
---@field float_winid integer|nil
---@field mapped_source_bufnr integer|nil

---@class TsQuickInfoPosition
---@field line integer
---@field offset integer

---@class TsDisplayPart
---@field text string
---@field kind string?

---@class TsQuickInfoTag
---@field name string
---@field text string|TsDisplayPart[]|nil

---@class TsQuickInfoBody
---@field displayString string?
---@field documentation string|TsDisplayPart[]|nil
---@field tags TsQuickInfoTag[]?
---@field canIncreaseVerbosityLevel boolean?
---@field start TsQuickInfoPosition?
---@field ['end'] TsQuickInfoPosition?

---@class VerboseHoverRequestOpts
---@field fallback_to_default boolean
---@field silent boolean|nil
---@field force_reopen boolean|nil

---@type VerboseHoverState
local state = {
  verbosity = 0,
  can_increase = false,
  requesting = false,
  generation = 0,
  source_bufnr = nil,
  source_winid = nil,
  source_pos = nil,
  float_winid = nil,
  mapped_source_bufnr = nil,
}

local hover_ns = vim.api.nvim_create_namespace("custom.verbose_hover")

---@return vim.lsp.Client|nil
---@param bufnr integer|nil
local function find_vtsls_client(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr or vim.api.nvim_get_current_buf(), name = "vtsls" })
  return clients[1]
end

---@param value string|TsDisplayPart[]|nil
---@return string|nil
local function flatten_display_parts(value)
  if value == nil then return nil end
  if type(value) == "string" then return value end
  if type(value) == "table" then
    assert(vim.islist(value), "quickinfo display parts must be a list")
    local chunks = {}
    for _, part in ipairs(value) do
      assert(type(part) == "table", "quickinfo display part must be a table")
      assert(type(part.text) == "string", "quickinfo display part must have string `.text`")
      chunks[#chunks + 1] = part.text
    end
    return table.concat(chunks)
  end
  error(string.format("unexpected quickinfo display value type: %s", type(value)))
end

---@param text string
---@return string
local function escape_markdown_code(text)
  local escaped = text:gsub("`", "\\`")
  return escaped
end

---@param text string
---@return string
local function make_codeblock(text)
  if text:match("^%s*[~`][~`][~`]") then return text end
  return "```tsx\n" .. text .. "\n```"
end

---@param parts string|TsDisplayPart[]|nil
---@return string
--- Mirrors VS Code TypeScript extension `convertLinkTags` behavior from
--- `languageFeatures/util/textRendering.ts` for quickinfo docs rendering.
local function convert_link_tags(parts)
  if parts == nil then return "" end
  if type(parts) == "string" then return parts end

  assert(vim.islist(parts), "quickinfo link parts must be a list")

  local out = {}
  ---@type { name: string|nil, text: string|nil, linkcode: boolean }|nil
  local current_link = nil

  local function flush_current_link()
    if not current_link then return end

    local text = current_link.text or current_link.name
    if text and text ~= "" then
      if text:match("^https?://") then
        local url, label = text:match("^(%S+)%s+(.+)$")
        if not url then
          if not current_link.linkcode then
            out[#out + 1] = "<" .. text .. ">"
          else
            out[#out + 1] = string.format("[`%s`](%s)", escape_markdown_code(text), text)
          end
        else
          local link_label = current_link.linkcode and ("`" .. escape_markdown_code(label) .. "`") or label
          out[#out + 1] = string.format("[%s](%s)", link_label, url)
        end
      else
        out[#out + 1] = escape_markdown_code(text)
      end
    end

    current_link = nil
  end

  for _, part in ipairs(parts) do
    assert(type(part) == "table", "quickinfo display part must be a table")
    assert(type(part.text) == "string", "quickinfo display part must have string `.text`")
    local kind = part.kind
    if kind == "link" then
      if current_link then
        flush_current_link()
      else
        current_link = { name = nil, text = nil, linkcode = part.text == "{@linkcode " }
      end
    elseif kind == "linkName" then
      if current_link then current_link.name = part.text end
    elseif kind == "linkText" then
      if current_link then current_link.text = part.text end
    else
      out[#out + 1] = part.text
    end
  end

  flush_current_link()
  return table.concat(out)
end

---@param tag TsQuickInfoTag
---@return string|nil
--- Mirrors VS Code TypeScript extension `getTagBodyText` behavior.
local function get_tag_body_text(tag)
  if not tag.text then return nil end

  local text = convert_link_tags(tag.text)
  if tag.name == "example" then
    local plain = flatten_display_parts(tag.text) or ""
    local caption, rest = plain:match("^<caption>(.-)</caption>%s*[\r\n]+(.*)$")
    if caption then return caption .. "\n" .. make_codeblock(rest) end
    return make_codeblock(plain)
  end

  if tag.name == "author" then
    local author, email = text:match("^(.+)%s<([%w%._%-]+@[%w%._%-]+)>$")
    if author and email then return author .. " " .. email end
    return text
  end

  if tag.name == "default" then return make_codeblock(text) end

  return text
end

---@param tag TsQuickInfoTag
---@return string|nil, string|nil
--- Mirrors VS Code TypeScript extension `getTagBody` behavior for param-like
--- tags, including `template` display-part handling.
local function get_tag_param_and_doc(tag)
  if tag.name == "template" and type(tag.text) == "table" then
    assert(vim.islist(tag.text), "template tag text must be a list")
    local template_parts = tag.text
    ---@cast template_parts TsDisplayPart[]
    local params = {}
    local docs = {}
    for _, part in ipairs(template_parts) do
      assert(type(part) == "table", "quickinfo display part must be a table")
      assert(type(part.text) == "string", "quickinfo display part must have string `.text`")
      if part.kind == "typeParameterName" then
        params[#params + 1] = part.text
      elseif part.kind == "text" then
        docs[#docs + 1] = convert_link_tags(part.text:gsub("^%s*-?%s*", ""))
      end
    end
    local param = table.concat(params, ", ")
    if param == "" then return nil, nil end
    return param, table.concat(docs, " ")
  end

  local converted = convert_link_tags(tag.text)
  local param, doc = converted:match("^%s*(%S+)%s*-?%s*(.*)$")
  if not param or param == "" then return nil, nil end
  return param, doc
end

---@param tag TsQuickInfoTag
---@return string|nil
--- Mirrors VS Code TypeScript extension `getTagDocumentation` behavior.
local function get_tag_documentation(tag)
  if tag.name == "augments" or tag.name == "extends" or tag.name == "param" or tag.name == "template" then
    local param, doc = get_tag_param_and_doc(tag)
    if param then
      local label = string.format("*@%s* `%s`", tag.name, param)
      if not doc or doc == "" then return label end
      if doc:match("[\r\n]") then return label .. "  \n" .. doc end
      return label .. " — " .. doc
    end
  end

  if tag.name == "returns" or tag.name == "return" then
    if not tag.text or flatten_display_parts(tag.text) == "" then return nil end
  end

  local label = string.format("*@%s*", tag.name)
  local text = get_tag_body_text(tag)
  if not text or text == "" then return label end
  if text:match("[\r\n]") then return label .. "  \n" .. text end
  return label .. " — " .. text
end

---@param tags TsQuickInfoTag[]|nil
---@return string
--- Mirrors VS Code TypeScript extension `tagsToMarkdown` behavior.
local function tags_to_markdown(tags)
  if not tags or #tags == 0 then return "" end

  local rendered = {}
  for _, tag in ipairs(tags) do
    local doc = get_tag_documentation(tag)
    if doc and doc ~= "" then rendered[#rendered + 1] = doc end
  end
  return table.concat(rendered, "  \n\n")
end

---@param body TsQuickInfoBody
---@return string[]
--- Mirrors VS Code TypeScript hover markdown assembly (`hover.ts` +
--- `documentationToMarkdown`) before passing into Neovim hover rendering.
local function build_markdown_lines(body)
  local sections = {}

  if body.displayString and body.displayString ~= "" then
    sections[#sections + 1] = "```typescript\n" .. body.displayString .. "\n```"
  end

  local docs = convert_link_tags(body.documentation)
  local tags = tags_to_markdown(body.tags)
  if docs ~= "" and tags ~= "" then
    sections[#sections + 1] = docs .. "\n\n" .. tags
  elseif docs ~= "" then
    sections[#sections + 1] = docs
  elseif tags ~= "" then
    sections[#sections + 1] = tags
  end

  return vim.split(table.concat(sections, "\n\n"), "\n", { plain = true })
end

---@param empty_response boolean
---@param silent boolean|nil
local function notify_hover_unavailable(empty_response, silent)
  if silent == true then return end
  if empty_response then
    vim.notify("Empty hover response", vim.log.levels.INFO)
  else
    vim.notify("No information available", vim.log.levels.INFO)
  end
end

---@param body TsQuickInfoBody
---@return lsp.Range|nil
local function body_to_range(body)
  local start = body.start
  local finish = body["end"]
  if not start or type(start) ~= "table" or not finish or type(finish) ~= "table" then return nil end
  if type(start.line) ~= "number" or type(start.offset) ~= "number" then return nil end
  if type(finish.line) ~= "number" or type(finish.offset) ~= "number" then return nil end

  return {
    start = { line = start.line - 1, character = start.offset - 1 },
    ["end"] = { line = finish.line - 1, character = finish.offset - 1 },
  }
end

local function clear_target_highlight()
  if state.source_bufnr and vim.api.nvim_buf_is_valid(state.source_bufnr) then
    vim.api.nvim_buf_clear_namespace(state.source_bufnr, hover_ns, 0, -1)
  end
end

---@param bufnr integer|nil
local function clear_hover_keymaps(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
  pcall(vim.keymap.del, "n", "+", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "=", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "-", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "_", { buffer = bufnr })
end

---@param bufnr integer|nil
local function set_hover_keymaps(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end

  vim.keymap.set("n", "+", function() M.expand() end, { buffer = bufnr, silent = true, nowait = true })
  vim.keymap.set("n", "=", function() M.expand() end, { buffer = bufnr, silent = true, nowait = true })
  vim.keymap.set("n", "-", function() M.collapse() end, { buffer = bufnr, silent = true, nowait = true })
  vim.keymap.set("n", "_", function() M.collapse() end, { buffer = bufnr, silent = true, nowait = true })
end

---@param lines string[]
---@param opts vim.lsp.util.open_floating_preview.Opts
---@return integer|nil, integer|nil
local function open_preview_from_source(lines, opts)
  local source_winid = state.source_winid
  local current_winid = vim.api.nvim_get_current_win()
  local came_from_hover = state.float_winid and current_winid == state.float_winid
  local can_use_source = source_winid
    and vim.api.nvim_win_is_valid(source_winid)
    and state.source_bufnr
    and vim.api.nvim_win_get_buf(source_winid) == state.source_bufnr

  if can_use_source and current_winid ~= source_winid then
    local ok_set = pcall(vim.api.nvim_set_current_win, source_winid)
    if ok_set then
      local ok_open, fbuf, fwin = pcall(vim.lsp.util.open_floating_preview, lines, "markdown", opts)
      if ok_open then
        if came_from_hover and fwin and vim.api.nvim_win_is_valid(fwin) then
          pcall(vim.api.nvim_set_current_win, fwin)
        else
          pcall(vim.api.nvim_set_current_win, current_winid)
        end
        return fbuf, fwin
      end
      pcall(vim.api.nvim_set_current_win, current_winid)
    end
  end

  local ok_open, fbuf, fwin = pcall(vim.lsp.util.open_floating_preview, lines, "markdown", opts)
  if ok_open then return fbuf, fwin end

  if state.float_winid and vim.api.nvim_win_is_valid(state.float_winid) then
    local fallback_opts = vim.tbl_extend("force", opts, { _update_win = state.float_winid })
    local ok_update, ubuf, uwin = pcall(vim.lsp.util.open_floating_preview, lines, "markdown", fallback_opts)
    if ok_update then return ubuf, uwin end
  end

  return nil, nil
end

---@param range lsp.Range|nil
---@param client vim.lsp.Client|nil
local function highlight_target(range, client)
  if not range or not state.source_bufnr or not vim.api.nvim_buf_is_valid(state.source_bufnr) then return end

  clear_target_highlight()

  local position_encoding = client and client.offset_encoding or "utf-16"
  local start_idx = vim.lsp.util._get_line_byte_from_position(state.source_bufnr, range.start, position_encoding)
  local end_idx = vim.lsp.util._get_line_byte_from_position(state.source_bufnr, range["end"], position_encoding)
  start_idx = start_idx or range.start.character
  end_idx = end_idx or range["end"].character

  vim.hl.range(
    state.source_bufnr,
    hover_ns,
    "LspReferenceTarget",
    { range.start.line, start_idx },
    { range["end"].line, end_idx },
    { priority = vim.hl.priorities.user }
  )
end

---@param body TsQuickInfoBody
---@param silent boolean|nil
---@param force_reopen boolean|nil
local function show(body, silent, force_reopen)
  local client = find_vtsls_client(state.source_bufnr)
  local opts = {
    focus_id = "textDocument/hover",
  }
  if force_reopen then
    opts.focus = false
  elseif state.float_winid and vim.api.nvim_win_is_valid(state.float_winid) then
    opts._update_win = state.float_winid
  end

  local hover = {
    contents = {
      kind = "markdown",
      value = table.concat(build_markdown_lines(body), "\n"),
    },
    range = body_to_range(body),
  }

  local lines = vim.lsp.util.convert_input_to_markdown_lines(hover.contents)
  lines = vim.split(table.concat(lines, "\n"), "\n", { trimempty = true })
  if vim.tbl_isempty(lines) then
    notify_hover_unavailable(true, silent)
    return
  end

  local _, winid = open_preview_from_source(lines, opts)
  if not winid or not vim.api.nvim_win_is_valid(winid) then
    notify_hover_unavailable(false, silent)
    return
  end
  state.float_winid = winid
  state.can_increase = body.canIncreaseVerbosityLevel == true

  highlight_target(hover.range, client)

  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(winid),
    once = true,
    callback = function()
      clear_target_highlight()
      clear_hover_keymaps(state.mapped_source_bufnr)
      state.mapped_source_bufnr = nil
      return true
    end,
  })

  local bufnr = vim.api.nvim_win_get_buf(winid)
  set_hover_keymaps(bufnr)

  if state.mapped_source_bufnr and state.mapped_source_bufnr ~= state.source_bufnr then
    clear_hover_keymaps(state.mapped_source_bufnr)
  end
  state.mapped_source_bufnr = state.source_bufnr
  set_hover_keymaps(state.mapped_source_bufnr)
end

---@param verbosity integer
---@param opts VerboseHoverRequestOpts
local function request_quickinfo(verbosity, opts)
  local client = find_vtsls_client(state.source_bufnr)
  if not client or not state.source_pos or not state.source_bufnr then
    if opts.fallback_to_default then vim.lsp.buf.hover({ silent = opts.silent }) end
    return
  end

  if state.requesting then return end

  state.requesting = true
  state.generation = state.generation + 1
  local current_generation = state.generation

  local params = {
    command = "typescript.tsserverRequest",
    arguments = {
      "quickinfo",
      {
        file = vim.api.nvim_buf_get_name(state.source_bufnr),
        line = state.source_pos[1] + 1,
        offset = state.source_pos[2] + 1,
        verbosityLevel = verbosity,
      },
    },
  }

  client:request("workspace/executeCommand", params, function(err, result)
    state.requesting = false
    if current_generation ~= state.generation then return end

    if err or not result or not result.body then
      if opts.fallback_to_default then
        vim.schedule(function() vim.lsp.buf.hover({ silent = opts.silent }) end)
      else
        notify_hover_unavailable(false, opts.silent)
      end
      return
    end

    vim.schedule(function()
      if current_generation ~= state.generation then return end
      show(result.body, opts.silent, opts.force_reopen)
    end)
  end, state.source_bufnr)
end

---@param config? vim.lsp.buf.hover.Opts
function M.hover(config)
  config = config or {}

  if state.float_winid and vim.api.nvim_win_is_valid(state.float_winid) then
    local ok, owner_bufnr = pcall(vim.api.nvim_win_get_var, state.float_winid, "textDocument/hover")
    if ok and owner_bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_set_current_win(state.float_winid)
      vim.cmd("stopinsert")
      return
    end
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  state.source_winid = vim.api.nvim_get_current_win()
  state.source_bufnr = vim.api.nvim_get_current_buf()
  state.source_pos = { cursor[1] - 1, cursor[2] }
  state.verbosity = 0

  request_quickinfo(state.verbosity, { fallback_to_default = true, silent = config.silent, force_reopen = false })
end

function M.expand()
  if not state.can_increase then return end
  state.verbosity = state.verbosity + 1
  request_quickinfo(state.verbosity, { fallback_to_default = false, silent = true, force_reopen = true })
end

function M.collapse()
  if state.verbosity == 0 then return end
  state.verbosity = state.verbosity - 1
  request_quickinfo(state.verbosity, { fallback_to_default = false, silent = true, force_reopen = true })
end

return M
