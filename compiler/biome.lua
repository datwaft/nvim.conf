if vim.fn.exists("current_compiler") == 1 then return end
vim.g.current_compiler = "biome"

vim.opt_local.isfname:append({ "[", "]" })
vim.bo.makeprg = "npx -y biome ci --reporter=github"
vim.bo.errorformat = {
  [[::%trror title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[::%tarning title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[::%totice title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[%-G%.%#]],
}
