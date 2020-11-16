return require('packer').startup(function()
  use({
    'wbthomason/packer.nvim',
    opt = true
  })
  use({
    'svermeulen/vimpeccable'
  })
  use({
    'svermeulen/nvim-moonmaker'
  })
  return use({
    'leafo/moonscript-vim'
  })
end)
