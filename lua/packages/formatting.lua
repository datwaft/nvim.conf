--- Applies the first code action of `kind` that the language server `server` offers for the whole buffer
--- `bufnr`, as `vim.lsp.buf.code_action()` would, but before returning: on save, the file is written right
--- after. Does nothing if the server isn't attached to the buffer.
---@param bufnr  integer
---@param server string  the server's name, as in `vim.lsp.config`
---@param kind   string
local function apply_code_action(bufnr, server, kind)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = server })[1]
  if not client then return end

  local function request(method, params)
    local response = assert(
      client:request_sync(method, params, 1000, bufnr),
      ("%s: %s timed out"):format(server, method)
    )
    assert(not response.err, ("%s: %s failed: %s"):format(server, method, vim.inspect(response.err)))
    return response.result
  end

  ---@type lsp.CodeAction[]? and commands, which have no kind
  local offered = request("textDocument/codeAction", {
    textDocument = { uri = vim.uri_from_bufnr(bufnr) },
    range = {
      ["start"] = { line = 0, character = 0 },
      ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
    },
    context = { only = { kind }, diagnostics = {} },
  })
  -- `only` is a request: a server may offer actions of other kinds too
  local action ---@type lsp.CodeAction?
  for _, candidate in ipairs(offered or {}) do
    if candidate.kind and (candidate.kind == kind or vim.startswith(candidate.kind, kind .. ".")) then
      action = candidate
      break
    end
  end
  if not action then return end

  -- Some servers, like `ruff`, give the action's edit only once it's resolved
  if not action.edit and client:supports_method("codeAction/resolve", bufnr) then
    action = request("codeAction/resolve", action)
  end
  if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding) end
  -- Its command runs after its edit
  if action.command then request("workspace/executeCommand", action.command) end
end

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      notify_no_formatters = false,
      formatters_by_ft = {
        css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        html = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        jsonc = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        lua = { "luafmt" },
        typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        vue = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        graphql = { "biome-check", "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_format", "ruff_organize_imports" },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        xml = { "xmlformat" },
        markdown = { "injected" },
      },
      formatters = {
        ["biome-check"] = { require_cwd = true },
        xmlformat = { prepend_args = { "--selfclose" } },
        prettierd = {
          condition = |_, context| -> vim.fn.fnamemodify(context.filename, ":e") ~= "ipynb",
        },
      },
      format_on_save = function(bufnr)
        if require("notebook_lsp").is_notebook(bufnr) then
          -- Language servers format notebooks as a whole, much faster than `injected` formats each code
          -- block, but sort their imports only as a code action
          apply_code_action(bufnr, "ruff", "notebook.source.organizeImports")
          return { lsp_format = "prefer", timeout_ms = 500 }
        end
        return { lsp_format = "fallback", timeout_ms = 500 }
      end,
    },
    init = function()
      vim.o.formatexpr = [[v:lua.require("conform").formatexpr()]]
    end,
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { "stevearc/conform.nvim", "williamboman/mason.nvim" },
    config = true,
  },
}
