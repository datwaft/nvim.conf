(local {: setup} (require :lualine))

(setup {:options {:globalstatus true
                  :theme "enfocado"}})
; Wait until neovim/neovim#19458 is fixed
        ;; :winbar {:lualine_a [:location]
        ;;          :lualine_b [:progress]
        ;;          :lualine_c [:filename]
        ;;          :lualine_x []
        ;;          :lualine_y []
        ;;          :lualine_z []}})
        ;; :inactive_winbar {:lualine_a [:location]
        ;;                   :lualine_b [:progress]
        ;;                   :lualine_c [:filename]
        ;;                   :lualine_x []
        ;;                   :lualine_y []
        ;;                   :lualine_z []}})
