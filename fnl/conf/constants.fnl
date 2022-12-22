(import-macros {: augroup!
                : clear!
                : autocmd!} :themis.event)

(local {: expand
        : mkdir} vim.fn)

;;; =========
;;; Constants
;;; =========

(local databases-folder (expand "~/.local/share/nvim/databases"))
(local icons {:error ""
              :warn ""
              :info ""
              :hint ""})
(local kind-icons {:Namespace ""
                   :Text " "
                   :Method " "
                   :Function " "
                   :Constructor " "
                   :Field "ﰠ "
                   :Variable " "
                   :Class "ﴯ "
                   :Interface " "
                   :Module " "
                   :Property "ﰠ "
                   :Unit "塞 "
                   :Value " "
                   :Enum " "
                   :Keyword " "
                   :Snippet " "
                   :Color " "
                   :File " "
                   :Reference " "
                   :Folder " "
                   :EnumMember " "
                   :Constant " "
                   :Struct "פּ "
                   :Event " "
                   :Operator " "
                   :TypeParameter " "
                   :Table ""
                   :Object " "
                   :Tag ""
                   :Array "[]"
                   :Boolean " "
                   :Number " "
                   :Null "ﳠ"
                   :String " "
                   :Calendar ""
                   :Watch " "
                   :Package ""})
(local source-labels {:buffer "[Buffer]"
                      :nvim_lsp "[LSP]"
                      :luasnip "[LuaSnip]"
                      :nvim_lua "[Lua]"
                      :latex_symbols "[LaTeX]"})
(local lisp-filetypes [:fennel
                       :clojure
                       :lisp
                       :racket
                       :scheme
                       :janet])

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
  (autocmd! VimEnter * '(mkdir databases-folder :p)
            {:once true}))
