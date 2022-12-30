(import-macros {: pack} :themis.pack.lazy)

(fn config []
  (local lualine (require :lualine))
  (lualine.setup {:options {:globalstatus true
                            :theme "auto"
                            :disabled_filetypes {:winbar ["qf"]}}
                  :winbar {:lualine_a [:location]
                           :lualine_b [:progress]
                           :lualine_c [:filename]}
                  :inactive_winbar {:lualine_a [:location]
                                    :lualine_b [:progress]
                                    :lualine_c [:filename]}}))

(pack "nvim-lualine/lualine.nvim" {:dependencies ["kyazdani42/nvim-web-devicons"]
                                   : config})
