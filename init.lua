local hotpot_path = vim.fn.stdpath("data") ..
                      "/site/pack/packer/start/hotpot.nvim"
if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
  vim.fn.system({
    "git", "clone", "https://github.com/rktjmp/hotpot.nvim", hotpot_path
  })
end
require("hotpot").setup({
  compiler = {
    macros = {env = "_COMPILER", compilerEnv = _G, allowedGlobals = false}
  }
})
require("core")
