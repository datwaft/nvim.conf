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
  use({
    'neoclide/coc.nvim',
    branch = 'release',
    config = require('plugins.cocnvim')
  })
  return use({
    'leafo/moonscript-vim'
  })
end)
