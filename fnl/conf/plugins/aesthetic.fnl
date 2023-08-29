(import-macros {: pack} :themis.pack.lazy)

[;; Better UI
 "stevearc/dressing.nvim"
 ;; Preview substitution
 (pack "markonm/traces.vim" {:config #(do (import-macros {: let!} :themis.var)
                                        (let! traces_abolish_integration 1))})
 ;; Preview ranges
 (pack "winston0410/range-highlight.nvim" {:dependencies ["winston0410/cmd-parser.nvim"]
                                           :config true})
 ;; Highlight color-codes
 (pack "NvChad/nvim-colorizer.lua" {:opts {:user_default_options {:mode "virtualtext"
                                                                  :names false}}})
 ;; Indent lines
 (pack "lukas-reineke/indent-blankline.nvim" {:opts {:char "▏"
                                                     :filetype_exclude [:terminal :help :NvimTree
                                                                        :markdown :text
                                                                        :TelescopePrompt :TelescopeResults
                                                                        (unpack conf.lisp-filetypes)]
                                                     :buftype_exclude [:terminal :nofile]}})]
