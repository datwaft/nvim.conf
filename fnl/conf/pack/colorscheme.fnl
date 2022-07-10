(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)
(local {:cmd cmd!} vim)
(local {:system system!} vim.fn)

(let! enfocado_style "nature")
(cmd! "colorscheme enfocado")
