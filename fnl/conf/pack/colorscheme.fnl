(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)
(import-macros {: augroup! : autocmd! : clear!} :themis.event)
(import-macros {: highlight!} :themis.highlight)

(local colors {:bg_0 "#181818"
               :bg_1 "#252525"
               :bg_2 "#3b3b3b"
               :dim_0 "#777777"
               :fg_0 "#b9b9b9"
               :fg_1 "#dedede"
               :red "#ed4a46"
               :green "#70b433"
               :yellow "#dbb32d"
               :blue "#368aeb"
               :magenta "#eb6eb7"
               :cyan "#3fc5b7"
               :orange "#e67f43"
               :violet "#a580e2"
               :br_red "#ff5e56"
               :br_green "#83c746"
               :br_yellow "#efc541"
               :br_blue "#4f9cfe"
               :br_magenta "#ff81ca"
               :br_cyan "#56d8c9"
               :br_orange "#fa9153"
               :br_violet "#b891f5"})

(augroup! enfocado-customization
  (clear!)
  (autocmd! ColorScheme enfocado
            '(do
               (highlight! TelescopePromptTitle [:bold] {:fg colors.bg_2 :bg colors.green})
               (highlight! TelescopePromptPrefix [] {:fg colors.green :bg colors.bg_2})
               (highlight! TelescopePromptCounter [] {:fg colors.dim_0 :bg colors.bg_2})
               (highlight! TelescopePromptNormal [] {:bg colors.bg_2})
               (highlight! TelescopePromptBorder [] {:fg colors.bg_2 :bg colors.bg_2})

               (highlight! TelescopeResultsTitle [:bold] {:fg colors.bg_1 :bg colors.bg_1})
               (highlight! TelescopeResultsBorder [] {:fg colors.bg_1 :bg colors.bg_1})

               (highlight! TelescopePreviewTitle [:bold] {:fg colors.bg_1 :bg colors.blue})
               (highlight! TelescopePreviewBorder [] {:fg colors.bg_1 :bg colors.bg_1}))
            {:nested true}))

(let! enfocado_style "nature")
(vim.cmd.colorscheme "enfocado")
