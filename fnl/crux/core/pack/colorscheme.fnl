(import-macros {: colorscheme!
                : let!} :crux.lib.macro.vim)
(local {: cmd!} (require :crux.lib.vim))

(let! enfocado_style "nature")
(cmd! "autocmd VimEnter * ++nested colorscheme enfocado")
