local M = {}

---@class SignatureHelpEntry
---@field client    vim.lsp.Client
---@field signature lsp.SignatureInformation

local signature_ns = vim.api.nvim_create_namespace("custom.signature_help")
local generation = 0

---@return nil
local function set_footer_highlight()
  local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  vim.api.nvim_set_hl(0, "SignatureHelpFooter", { fg = comment.fg })
end

set_footer_highlight()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("signature-help-highlights", { clear = true }),
  callback = set_footer_highlight,
})

---@return nil
function M.signature_help()
  local source_bufnr = vim.api.nvim_get_current_buf()
  local source_winid = vim.api.nvim_get_current_win()
  local source_pos = vim.api.nvim_win_get_cursor(source_winid)
  local changedtick = vim.api.nvim_buf_get_changedtick(source_bufnr)
  generation = generation + 1
  local request_generation = generation

  vim.lsp.buf_request_all(
    source_bufnr, "textDocument/signatureHelp",
    function(client)
      return vim.lsp.util.make_position_params(source_winid, client.offset_encoding)
    end,
    function(results)
      -- Ignore responses after typing, moving, switching windows, or a newer request.
      if request_generation ~= generation or not vim.api.nvim_buf_is_valid(source_bufnr)
        or vim.api.nvim_get_current_win() ~= source_winid or vim.api.nvim_get_current_buf() ~= source_bufnr
        or vim.api.nvim_buf_get_changedtick(source_bufnr) ~= changedtick
        or not vim.deep_equal(vim.api.nvim_win_get_cursor(source_winid), source_pos) then
        return
      end

      ---@type SignatureHelpEntry[]
      local signatures = {}
      local active_signature = 1
      for client_id, response in vim.spairs(results) do
        local client = vim.lsp.get_client_by_id(client_id)
        if client then
          if response.err then
            vim.notify(client.name .. ": " .. response.err.message, vim.log.levels.ERROR)
          elseif response.result and response.result ~= vim.NIL then
            local result = response.result
            local active = result.activeSignature or 0
            if active < 0 or active >= #result.signatures then active = 0 end
            for i, signature in ipairs(result.signatures) do
              signature = vim.deepcopy(signature)
              signature.activeParameter = signature.activeParameter or result.activeParameter
              signatures[#signatures + 1] = { client = client, signature = signature }
              if i == active + 1 then active_signature = #signatures end
            end
          end
        end
      end

      if #signatures == 0 then
        vim.notify("No signature help available", vim.log.levels.INFO)
        return
      end

      local index = active_signature

      ---@param update_win? integer
      ---@return integer | nil, integer | nil
      local function show_signature(update_win)
        if update_win and not vim.api.nvim_win_is_valid(update_win) then return end

        local entry = signatures[index]
        -- Notebook buffers are Markdown, but their client knows the code-cell language.
        local language = entry.client.get_language_id(source_bufnr, vim.bo[source_bufnr].filetype)
        local triggers = vim.tbl_get(entry.client.server_capabilities, "signatureHelpProvider", "triggerCharacters")
        local lines, active_parameter = vim.lsp.util.convert_signature_help_to_markdown_lines(
          { signatures = { entry.signature } },
          language,
          triggers
        )
        if not lines then return end

        local opts = {
          focus_id = "textDocument/signatureHelp",
          title = "",
          _update_win = update_win,
        }
        local bufnr, winid = vim.lsp.util.open_floating_preview(lines, "markdown", opts)
        if update_win then
          -- Recompute placement from the source when overloads have different sizes.
          vim.api.nvim_win_call(source_winid, function()
            local width, height = vim.lsp.util._make_floating_popup_size(lines, {
              wrap_at = vim.api.nvim_win_get_width(source_winid),
            })
            vim.api.nvim_win_set_config(winid, vim.lsp.util.make_floating_popup_options(width, height, opts))
          end)
          local height = vim.api.nvim_win_get_height(winid)
          local text_height = vim.api.nvim_win_text_height(winid, { max_height = height }).all
          vim.api.nvim_win_set_config(winid, { height = math.max(1, math.min(height, text_height)) })
        end
        if #signatures > 1 then
          local border = vim.opt.winborder:get()
          local bottom = type(border) == "table" and border[6] or "─"
          local left = type(border) == "table" and border[8] or "│"
          local right = type(border) == "table" and border[4] or "│"
          vim.api.nvim_win_set_config(winid, {
            footer = {
              { bottom .. bottom, "FloatBorder" },
              { left, "FloatBorder" },
              { (" %d/%d "):format(index, #signatures), "SignatureHelpFooter" },
              { right, "FloatBorder" },
              { bottom, "FloatBorder" },
            },
            footer_pos = "right",
          })
        end

        vim.api.nvim_buf_clear_namespace(bufnr, signature_ns, 0, -1)
        if active_parameter then
          vim.hl.range(
            bufnr,
            signature_ns,
            "LspSignatureActiveParameter",
            { active_parameter[1], active_parameter[2] },
            { active_parameter[3], active_parameter[4] }
          )
        end
        return bufnr, winid
      end

      local bufnr, winid = show_signature()
      if bufnr and winid and #signatures > 1 then
        vim.keymap.set("n", "<Plug>(nvim.lsp.ctrl-s)", function()
          index = (index % #signatures) + 1
          show_signature(winid)
        end, { buffer = bufnr, desc = "Cycle next signature" }
        )
        if vim.fn.hasmapto("<Plug>(nvim.lsp.ctrl-s)", "n") == 0 then
          vim.keymap.set("n", "<C-s>", "<Plug>(nvim.lsp.ctrl-s)", {
            buffer = bufnr,
            desc = "Cycle next signature",
          })
        end
      end
    end
  )
end

return M
