local M = {}

---@class VerboseHoverState
---@field verbosity            integer
---@field can_increase         boolean
---@field pending_req          VerboseHoverRequest | nil
---@field latest_req_id        integer
---@field source_bufnr         integer | nil
---@field source_winid         integer | nil
---@field source_pos           { [1]: integer, [2]: integer } | nil
---@field float_winid          integer | nil
---@field mapped_source_bufnr  integer | nil
---@field saved_source_keymaps table<string, table>

---@class VerboseHoverRequestSpec
---@field winid       integer
---@field bufnr       integer
---@field pos         { [1]: integer, [2]: integer }
---@field verbosity   integer
---@field float_winid integer | nil

---@class VerboseHoverRequest : VerboseHoverRequestSpec
---@field id          integer
---@field changedtick integer
---@field cancelled   boolean

---@class TsQuickInfoPosition
---@field line   integer
---@field offset integer

---@class TsDisplayPart
---@field text string
---@field kind string?

---@class TsQuickInfoTag
---@field name string
---@field text string | TsDisplayPart[] | nil

---@class TsQuickInfoBody
---@field displayString             string?
---@field documentation             string | TsDisplayPart[] | nil
---@field tags                      TsQuickInfoTag[]?
---@field canIncreaseVerbosityLevel boolean?
---@field start                     TsQuickInfoPosition?
---@field ["end"]                   TsQuickInfoPosition?

---@class VerboseHoverRequestOpts
---@field fallback_to_default boolean
---@field silent              boolean | nil
---@field force_reopen        boolean | nil

---@type VerboseHoverState
local state = {
  verbosity = 0,
  can_increase = false,
  pending_req = nil,
  latest_req_id = 0,
  source_bufnr = nil,
  source_winid = nil,
  source_pos = nil,
  float_winid = nil,
  mapped_source_bufnr = nil,
  saved_source_keymaps = {},
}

const hover_ns = vim.api.nvim_create_namespace("custom.verbose_hover")

do
  local float_footer = vim.api.nvim_get_hl(0, { name = "FloatFooter", link = false })
  local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
  local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  vim.api.nvim_set_hl(0, "VerboseHoverFooterActive", {
    default = true,
    fg = float_footer.fg,
    bg = normal_float.bg,
    bold = true,
    italic = false,
  })
  vim.api.nvim_set_hl(0, "VerboseHoverFooterInactive", {
    default = true,
    fg = comment.fg,
    bg = normal_float.bg,
    italic = false,
  })
end

---@return vim.lsp.Client | nil
---@param bufnr integer | nil
local function find_vtsls_client(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr ?? vim.api.nvim_get_current_buf(), name = "vtsls" })
  return clients[1]
end

---@param value string | TsDisplayPart[] | nil
---@return string | nil
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

---@param parts string | TsDisplayPart[] | nil
---@return string
--- Mirrors VS Code TypeScript extension `convertLinkTags` behavior from
--- `languageFeatures/util/textRendering.ts` for quickinfo docs rendering.
local function convert_link_tags(parts)
  if parts == nil then return "" end
  if type(parts) == "string" then return parts end

  assert(vim.islist(parts), "quickinfo link parts must be a list")

  local out = {}
  ---@type { name: string | nil, text: string | nil, linkcode: boolean } | nil
  local current_link = nil

  local function flush_current_link()
    if not current_link then return end

    local text = current_link.text ?? current_link.name
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
          local link_label = current_link.linkcode ? ("`" .. escape_markdown_code(label) .. "`") : label
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
---@return string | nil
--- Mirrors VS Code TypeScript extension `getTagBodyText` behavior.
local function get_tag_body_text(tag)
  if not tag.text then return nil end

  local text = convert_link_tags(tag.text)
  if tag.name == "example" then
    local plain = flatten_display_parts(tag.text) ?? ""
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
---@return string | nil, string | nil
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
---@return string | nil
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

---@param tags TsQuickInfoTag[] | nil
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
---@param silent         boolean | nil
local function notify_hover_unavailable(empty_response, silent)
  if silent == true then return end
  if empty_response then
    vim.notify("Empty hover response", vim.log.levels.INFO)
  else
    vim.notify("No information available", vim.log.levels.INFO)
  end
end

---@param body TsQuickInfoBody
---@return lsp.Range | nil
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

const hover_augroup = vim.api.nvim_create_augroup("verbose-hover", { clear = true })

const hover_key_groups = {
  {
    { "+", "=" },
    function()
      M.expand()
    end,
  },
  {
    { "-", "_" },
    function()
      M.collapse()
    end,
  },
}

local function clear_source_keymaps()
  local bufnr = state.mapped_source_bufnr
  state.mapped_source_bufnr = nil
  local saved_keymaps = state.saved_source_keymaps
  state.saved_source_keymaps = {}
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
  vim.api.nvim_buf_call(bufnr, function()
    for _, group in ipairs(hover_key_groups) do
      for _, lhs in ipairs(group[1]) do
        pcall(vim.keymap.del, "n", lhs, { buffer = bufnr })
        if saved_keymaps[lhs] then vim.fn.mapset("n", false, saved_keymaps[lhs]) end
      end
    end
  end)
end

---@param bufnr integer | nil
local function set_float_keymaps(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
  for _, group in ipairs(hover_key_groups) do
    vim.keymap.set("n", group[1], group[2], { buffer = bufnr, silent = true, nowait = true })
  end
end

---@param bufnr integer | nil
local function set_source_keymaps(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
  if state.mapped_source_bufnr == bufnr then return end
  clear_source_keymaps()
  vim.api.nvim_buf_call(bufnr, function()
    for _, group in ipairs(hover_key_groups) do
      for _, lhs in ipairs(group[1]) do
        local existing = vim.fn.maparg(lhs, "n", false, true)
        if existing and existing.buffer == 1 then state.saved_source_keymaps[lhs] = existing end
      end
      vim.keymap.set("n", group[1], group[2], { buffer = bufnr, silent = true, nowait = true })
    end
  end)
  state.mapped_source_bufnr = bufnr
end

---@param winid integer
local function set_hover_controls(winid)
  if not winid or not vim.api.nvim_win_is_valid(winid) then return end

  local can_decrease = state.verbosity > 0
  if not state.can_increase and not can_decrease then
    pcall(vim.api.nvim_win_set_config, winid, { footer = nil })
    return
  end

  local winborder = vim.opt.winborder:get()
  local border_bottom = "─"
  local border_right = "│"
  local border_left = "│"
  if type(winborder) == "table" and type(winborder[6]) == "string" and winborder[6] ~= "" then
    border_bottom = winborder[6]
  end
  if type(winborder) == "table" and type(winborder[4]) == "string" and winborder[4] ~= "" then
    border_right = winborder[4]
  end
  if type(winborder) == "table" and type(winborder[8]) == "string" and winborder[8] ~= "" then
    border_left = winborder[8]
  end

  local dec_hl = can_decrease ? "VerboseHoverFooterActive" : "VerboseHoverFooterInactive"
  local inc_hl = state.can_increase ? "VerboseHoverFooterActive" : "VerboseHoverFooterInactive"
  local dec_label = "−"
  local inc_label = "+"

  pcall(vim.api.nvim_win_set_config, winid, {
    footer = {
      { border_bottom .. border_bottom .. border_bottom, "FloatBorder" },
      { border_left, "FloatBorder" },
      { " ", "FloatBorder" },
      { dec_label, dec_hl },
      { " ", "FloatBorder" },
      { inc_label, inc_hl },
      { " ", "FloatBorder" },
      { border_right, "FloatBorder" },
      { border_bottom .. border_bottom .. border_bottom, "FloatBorder" },
    },
    footer_pos = "right",
  })
end

---@param req   VerboseHoverRequest
---@param lines string[]
---@param opts  vim.lsp.util.open_floating_preview.Opts
---@return integer | nil, integer | nil
local function open_preview_from_source(req, lines, opts)
  local source_winid = req.winid
  local current_winid = vim.api.nvim_get_current_win()
  local came_from_hover = state.float_winid and current_winid == state.float_winid
  local can_use_source = vim.api.nvim_win_is_valid(source_winid)
    and vim.api.nvim_win_get_buf(source_winid) == req.bufnr

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

---@param range lsp.Range | nil
local function highlight_target(range)
  if not range or not state.source_bufnr or not vim.api.nvim_buf_is_valid(state.source_bufnr) then return end

  clear_target_highlight()

  local lines = vim.api.nvim_buf_get_lines(state.source_bufnr, range.start.line, range["end"].line + 1, false)
  local start_line = lines[1] ?? ""
  local end_line = lines[range["end"].line - range.start.line + 1] ?? ""
  -- tsserver quickinfo ranges are always UTF-16.
  local start_idx = vim.str_byteindex(start_line, "utf-16", range.start.character, false)
  local end_idx = vim.str_byteindex(end_line, "utf-16", range["end"].character, false)

  vim.hl.range(
    state.source_bufnr,
    hover_ns,
    "LspReferenceTarget",
    { range.start.line, start_idx },
    { range["end"].line, end_idx },
    { priority = vim.hl.priorities.user }
  )
end

---@param winid integer | nil
---@return boolean
local function is_float(winid)
  return winid ~= nil and vim.api.nvim_win_is_valid(winid) and vim.api.nvim_win_get_config(winid).relative ~= ""
end

---@param req          VerboseHoverRequest
---@param body         TsQuickInfoBody
---@param silent       boolean | nil
---@param force_reopen boolean | nil
local function show(req, body, silent, force_reopen)
  local opts = {
    focus_id = "textDocument/hover",
  }
  if force_reopen then
    opts.focus = false
  elseif is_float(state.float_winid) and state.source_bufnr == req.bufnr and state.source_winid == req.winid then
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

  local _, winid = open_preview_from_source(req, lines, opts)
  if not winid or not vim.api.nvim_win_is_valid(winid) then
    notify_hover_unavailable(false, silent)
    return
  end
  clear_target_highlight()
  state.source_winid = req.winid
  state.source_bufnr = req.bufnr
  state.source_pos = req.pos
  state.verbosity = req.verbosity
  state.float_winid = winid
  state.can_increase = body.canIncreaseVerbosityLevel == true

  highlight_target(hover.range)

  vim.api.nvim_create_autocmd("WinClosed", {
    group = hover_augroup,
    pattern = tostring(winid),
    once = true,
    callback = function()
      if state.float_winid == winid then
        state.float_winid = nil
        if state.pending_req and state.pending_req.float_winid == winid then
          state.pending_req.cancelled = true
          state.pending_req = nil
        end
        clear_target_highlight()
        clear_source_keymaps()
      end
    end,
  })

  local bufnr = vim.api.nvim_win_get_buf(winid)
  set_hover_controls(winid)
  set_float_keymaps(bufnr)

  if state.can_increase or state.verbosity > 0 then
    set_source_keymaps(state.source_bufnr)
  else
    clear_source_keymaps()
  end
end

---@param req VerboseHoverRequest
---@return boolean
local function is_request_valid(req)
  if req.cancelled or req.id ~= state.latest_req_id then return false end
  if not vim.api.nvim_buf_is_valid(req.bufnr) or not vim.api.nvim_win_is_valid(req.winid) then return false end
  if vim.api.nvim_win_get_buf(req.winid) ~= req.bufnr then return false end
  if vim.api.nvim_buf_get_changedtick(req.bufnr) ~= req.changedtick then return false end
  if not vim.deep_equal(vim.api.nvim_win_get_cursor(req.winid), { req.pos[1] + 1, req.pos[2] }) then return false end
  if req.float_winid then
    return state.float_winid == req.float_winid and is_float(state.float_winid)
  end
  return vim.api.nvim_get_current_win() == req.winid
end

---@param req  VerboseHoverRequest
---@param opts VerboseHoverRequestOpts
local function finish_unavailable(req, opts)
  vim.schedule(function()
    if not is_request_valid(req) then return end
    if opts.fallback_to_default then
      vim.lsp.buf.hover({ silent = opts.silent })
    else
      notify_hover_unavailable(false, opts.silent)
    end
  end)
end

---@param spec VerboseHoverRequestSpec
---@param opts VerboseHoverRequestOpts
local function request_quickinfo(spec, opts)
  local client = find_vtsls_client(spec.bufnr)
  if not client then
    if opts.fallback_to_default then vim.lsp.buf.hover({ silent = opts.silent }) end
    return
  end

  if state.pending_req and spec.float_winid then return end

  state.latest_req_id += 1
  ---@type VerboseHoverRequest
  local req = {
    id = state.latest_req_id,
    winid = spec.winid,
    bufnr = spec.bufnr,
    pos = spec.pos,
    changedtick = vim.api.nvim_buf_get_changedtick(spec.bufnr),
    verbosity = spec.verbosity,
    float_winid = spec.float_winid,
    cancelled = false,
  }
  state.pending_req = req

  local line_text = vim.api.nvim_buf_get_lines(req.bufnr, req.pos[1], req.pos[1] + 1, false)[1] ?? ""
  local utf16_col = vim.str_utfindex(line_text, "utf-16", req.pos[2], false)

  local params = {
    command = "typescript.tsserverRequest",
    arguments = {
      "quickinfo",
      {
        file = vim.api.nvim_buf_get_name(req.bufnr),
        line = req.pos[1] + 1,
        offset = utf16_col + 1,
        verbosityLevel = req.verbosity,
      },
    },
  }

  local ok = client:request("workspace/executeCommand", params, function(err, result)
    if state.pending_req == req then state.pending_req = nil end
    if req.cancelled or req.id ~= state.latest_req_id then return end
    if err or not result or not result.body then
      finish_unavailable(req, opts)
      return
    end
    vim.schedule(function()
      if not is_request_valid(req) then return end
      show(req, result.body, opts.silent, opts.force_reopen)
    end)
  end, req.bufnr
  )
  if not ok then
    if state.pending_req == req then state.pending_req = nil end
    finish_unavailable(req, opts)
  end
end

---@param config? vim.lsp.buf.hover.Opts
function M.hover(config)
  config = config ?? {}

  if state.float_winid then
    if is_float(state.float_winid) then
      local owner_bufnr = vim.npcall(vim.api.nvim_win_get_var, state.float_winid, "textDocument/hover")
      if owner_bufnr == vim.api.nvim_get_current_buf() then
        vim.api.nvim_set_current_win(state.float_winid)
        vim.cmd("stopinsert")
        return
      end
    else
      -- A hover docked into a normal split (`<C-w>H`) skips `WinClosed`; release it before hovering again.
      state.float_winid = nil
      clear_target_highlight()
      clear_source_keymaps()
    end
  end

  local winid = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(winid)
  request_quickinfo({
    winid = winid,
    bufnr = vim.api.nvim_get_current_buf(),
    pos = { cursor[1] - 1, cursor[2] },
    verbosity = 0,
    float_winid = nil,
  }, { fallback_to_default = true, silent = config.silent, force_reopen = false })
end

---@param next_verbosity integer
local function adjust(next_verbosity)
  if not state.source_winid or not state.source_bufnr or not state.source_pos or not state.float_winid then return end
  if not vim.api.nvim_buf_is_valid(state.source_bufnr) then return end
  request_quickinfo({
    winid = state.source_winid,
    bufnr = state.source_bufnr,
    pos = state.source_pos,
    verbosity = next_verbosity,
    float_winid = state.float_winid,
  }, { fallback_to_default = false, silent = true, force_reopen = true })
end

function M.expand()
  if not state.can_increase then return end
  adjust(state.verbosity + 1)
end

function M.collapse()
  if state.verbosity == 0 then return end
  adjust(state.verbosity - 1)
end

return M
