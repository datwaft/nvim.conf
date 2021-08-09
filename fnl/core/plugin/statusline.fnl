(module core.plugin.statusline
  {require-macros [core.macros]})

(let! bubbly_palette
  {:background "#24292e"
   :foreground "#d1d5da"
   :black "#24292e"
   :red "#f14c4c"
   :green "#23d18b"
   :yellow "#e2e210"
   :blue "#3b8eea"
   :purple "#bc3fbc"
   :cyan "#29b7da"
   :white "#d1d5da"
   :lightgrey "#666666"
   :darkgrey "#404247"})

(let! bubbly_colors {:total_buffer_number "red"
                     :branch "yellow"})

(let! bubbly_styles {:total_buffer_number "bold"})

(let! bubbly_statusline
  [:mode
   :truncate
   :path :branch :lsp_status.diagnostics :lsp_status.messages
   :divisor
   :total_buffer_number :filetype :progress])

(let! bubbly_filter
  {:branch [:fern :packer :NvimTree]
   :total_buffer_number [:fern :packer :NvimTree]
   :path [:fern :packer :NvimTree]
   :filetype [:fern :packer :NvimTree]})
