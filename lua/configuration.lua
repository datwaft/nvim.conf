vim.o.mouse = 'a'
do
  local expandtab = true
  vim.o.expandtab = expandtab
  vim.bo.expandtab = expandtab
end
do
  local smarttab = true
  vim.o.smarttab = smarttab
end
do
  local tabstop = 3
  vim.o.tabstop = tabstop
  vim.bo.tabstop = tabstop
end
do
  local shiftwidth = vim.o.tabstop
  vim.o.shiftwidth = shiftwidth
  vim.bo.shiftwidth = shiftwidth
end
do
  local softtabstop = vim.o.tabstop
  vim.o.softtabstop = softtabstop
  vim.bo.softtabstop = softtabstop
end
do
  local autoindent = true
  vim.o.autoindent = autoindent
  vim.bo.autoindent = autoindent
  return autoindent
end
