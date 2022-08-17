(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)

(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

(augroup! colorscheme-customization
  (clear!)
  (autocmd! Colorscheme enfocado
            '(vim.cmd.highlight {:args [:link :Whitespace :NonText] :bang true})
            {:nested true}))

(let! enfocado_style "nature")
(vim.cmd.colorscheme "enfocado")
