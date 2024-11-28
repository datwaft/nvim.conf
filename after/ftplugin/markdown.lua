if vim.bo.buftype ~= "nofile" then
  require("quarto").activate()
end
