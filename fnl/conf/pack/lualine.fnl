(local {: setup} (require :lualine))

(setup {:options {:globalstatus true
                  :theme "auto"}
        :winbar {:lualine_a [:location]
                 :lualine_b [:progress]
                 :lualine_c [:filename]
                 :lualine_x []
                 :lualine_y []
                 :lualine_z []}
        :inactive_winbar {:lualine_a [:location]
                          :lualine_b [:progress]
                          :lualine_c [:filename]
                          :lualine_x []
                          :lualine_y []
                          :lualine_z []}})
