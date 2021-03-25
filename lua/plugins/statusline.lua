-- ========================
-- STATUSLINE CONFIGURATION
-- ========================
-- Created by datwaft<github.com/datwaft>

return function()
  vim.g.bubbly_palette = {
    background = "#34343c",
    foreground = "#c5cdd9",
    black = "#3e4249",
    red = "#ec7279",
    green = "#a0c980",
    yellow = "#deb974",
    blue = "#6cb6eb",
    purple = "#d38aea",
    cyan = "#5dbbc1",
    white = "#c5cdd9",
    lightgrey = "#57595e",
    darkgrey = "#404247",
  }
  vim.g.bubbly_colors = {
    total_buffer_number = 'red',
  }
  vim.g.bubbly_styles = {
    total_buffer_number = 'bold',
  }
  vim.g.bubbly_statusline = {
    'mode',

    'truncate',

    'path',
    'branch',
    'lsp_status.diagnostics',
    'lsp_status.messages',

    'divisor',

    'total_buffer_number',
    'filetype',
    'progress',
  }
  vim.g.bubbly_filter = {
    branch = {
      'fern',
      'packer',
    },
    total_buffer_number = {
      'fern',
      'packer',
    },
    path = {
      'fern',
      'packer',
    },
    filetype = {
      'fern',
      'packer',
    },
  }
end
