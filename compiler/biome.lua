if vim.fn.exists("current_compiler") == 1 then return end
vim.g.current_compiler = "biome"

for _, character in ipairs({ "[", "]" }) do
  if not vim.o.isfname:find(character, 1, true) then vim.o.isfname ..= "," .. character end
end
vim.bo.makeprg = "npx -y biome ci --reporter=github"
---@diagnostic disable-next-line: assign-type-mismatch
vim.bo.errorformat = {
  [[::%trror title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[::%tarning title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[::%totice title=%*[^\,]\,file=%f\,line=%l\,endLine=%e\,col=%c\,endColumn=%k::%m]],
  [[%-G%.%#]],
}
