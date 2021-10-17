(import-macros {: colorscheme!
                : highlight!} :crux.lib.macro.vim)
(local {: setup} (require :catppuccino))

(setup {:colorscheme "dark_catppuccino"
        :transparency false
        :term_colors true
        :styles {:comments "italic"
                 :functions "italic"
                 :keywords "italic"
                 :strings "NONE"
                 :variables "NONE"}
        :integrations {:treesitter true
                       :native_lsp {:enabled true
                                    :virtual_text {:errors "italic"
                                                   :hints "italic"
                                                   :warnings "italic"
                                                   :information "italic"}
                                    :underlines {:errors "underline"
                                                 :hints "underline"
                                                 :warnings "underline"
                                                 :information "underline"}}
                       :lsp_trouble false
                       :lsp_saga false
                       :gitgutter false
                       :gitsigns true
                       :telescope true
                       :nvimtree {:enabled true
                                  :show_root true}
                       :which_key true
                       :indent_blankline {:enabled true
                                          :colored_indent_levels true}
                       :dashboard false
                       :neogit false
                       :vim_sneak false
                       :fern false
                       :barbar false
                       :bufferline false
                       :markdown true
                       :lightspeed false
                       :ts_rainbow true
                       :hop false}})

(colorscheme! catppuccino)

(highlight! SpellBad {:ctermfg 9
                      :guifg "#e06c75"
                      :gui [:underline]})

(highlight! DapBreakpoint {:ctermfg 12 :guifg "#e06c75" :cterm [:bold] :gui [:bold]})
(highlight! DapBreakpointCondition {:ctermfg 14 :guifg "#dbc074" :cterm [:bold] :gui [:bold]})
(highlight! DapLogPoint {:ctermfg 9 :guifg "#61afef" :cterm [:bold] :gui [:bold]})
(highlight! DapStopped {:ctermfg 15 :guifg "#dfdfe0" :cterm [:bold] :gui [:bold]})
(highlight! DapBreakpointRejected {:ctermfg 7 :guifg "#abb2bf" :cterm [:bold] :gui [:bold]})
