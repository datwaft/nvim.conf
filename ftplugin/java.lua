local _local_1_ = require("conf.lsp")
local _local_2_ = _local_1_["global-options"]
local on_attach = _local_2_["on_attach"]
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local function get_server(name)
  local servers = mason_lspconfig.get_installed_servers()
  if vim.tbl_contains(servers, name) then
    return true, lspconfig[name]
  else
    return false, nil
  end
end
local ok, jdtls = get_server("jdtls")
if (ok == false) then
  vim.notify("mason-lspconfig: jdtls not found, please install it first", vim.log.levels.ERROR)
  return
else
end
local default_config = jdtls.document_config.default_config
local config = {on_attach = on_attach, cmd = default_config.cmd, root_dir = default_config.root_dir(), settings = {java = {}}, init_options = {bundles = {}}}
do
  local jdtls0 = require("jdtls")
  jdtls0.start_or_attach(config)
end
vim.api.nvim_create_augroup("jdtls-organize-imports-on-save", {clear = false})
vim.api.nvim_clear_autocmds({group = "jdtls-organize-imports-on-save"})
local function _5_()
  local params = vim.lsp.util.make_range_params()
  local bufnr = vim.api.nvim_get_current_buf()
  params.context = {diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr)}
  local result, err = vim.lsp.buf_request_sync(0, "java/organizeImports", params)
  if err then
    return vim.notify(("Error on organize imports: " .. err), vim.log.levels.ERROR)
  else
    local result0 = vim.tbl_values(result)
    if (result0 and (result0)[1].result) then
      return vim.lsp.util.apply_workspace_edit((result0)[1].result, "utf-16")
    else
      return nil
    end
  end
end
return vim.api.nvim_create_autocmd("BufWritePre", {callback = _5_, desc = "'(let [params (vim.lsp.util.make_range_params) bufnr (vim.api.nvim_get_current_buf)] (set params.context {:diagnostics (vim.lsp.diagnostic.get_line_diagnostics bufnr)}) (local (result err) (vim.lsp.buf_request_sync 0 \"java/organizeImports\" params)) (if err (vim.notify (.. \"Error on organize imports: \" err) vim.log.levels.ERROR) (let [result (vim.tbl_values result)] (if (and result (. result 1 \"result\")) (vim.lsp.util.apply_workspace_edit (. result 1 \"result\") \"utf-16\")))))", group = "jdtls-organize-imports-on-save", pattern = "*.java"})