(import-macros {: let!} :conf.macro.var)
(import-macros {: autocmd!} :conf.macro.event)

(let! enfocado_style "nature")
(autocmd! VimEnter * ++nested "colorscheme enfocado")
