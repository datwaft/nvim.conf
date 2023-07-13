(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

;;; =========
;;; Constants
;;; =========

(local databases-folder (.. (vim.fn.stdpath "data") "/databases"))

(local icons {:error " "
              :warn  " "
              :info  " "
              :hint  " "
              :ok    " "})

(local kind-icons {:Namespace     " "
                   :Text          "󰉿 "
                   :Method        "󰆧 "
                   :Function      "󰊕 "
                   :Constructor   " "
                   :Field         "󰜢 "
                   :Variable      " "
                   :Class         "󰠱 "
                   :Interface     " "
                   :Module        " "
                   :Property      "󰜢 "
                   :Unit          "󰑭 "
                   :Value         "󰎠 "
                   :Enum          " "
                   :Keyword       "󰌋 "
                   :Snippet       " "
                   :Color         "󰏘 "
                   :File          "󰈙 "
                   :Reference     "󰈇 "
                   :Folder        "󰉋 "
                   :EnumMember    " "
                   :Constant      "󰏿 "
                   :Struct        "󰙅 "
                   :Event         " "
                   :Operator      " "
                   :TypeParameter " "
                   :Table         " "
                   :Object        " "
                   :Tag           " "
                   :Array         "[]"
                   :Boolean       " "
                   :Number        " "
                   :Null          "󰟢 "
                   :String        " "
                   :Calendar      " "
                   :Watch         " "
                   :Package       " "})

(local source-labels {:buffer        "[Buffer]"
                      :nvim_lsp      "[LSP]"
                      :luasnip       "[LuaSnip]"
                      :nvim_lua      "[Lua]"
                      :latex_symbols "[LaTeX]"})

(local lisp-filetypes [:fennel
                       :clojure
                       :lisp
                       :racket
                       :scheme
                       :janet
                       :hy])

(tset _G :conf {: databases-folder
                : icons
                : kind-icons
                : source-labels
                : lisp-filetypes})

;;; =====
;;; Setup
;;; =====

;; Create folders if non-existent
(augroup! create-folders-if-non-existent
  (clear!)
  (autocmd! VimEnter * #(vim.fn.mkdir databases-folder :p)
            {:once true}))
