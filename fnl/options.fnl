;; Indentation
(set! expandtab)
(set! shiftwidth 0)
(set! tabstop 2)

;; Wrapping
(set! linebreak)
(set! breakindent)
(set! breakindentopt ["shift:2"])
(set! showbreak "↳ ")

;; Undo persistence
(set! undofile)

;; Spelling
(set! spell)
(set! spelllang [:en :es])
(set! spelloptions [:camel :noplainbuffer])
(let [spell-folder (.. (vim.fn.stdpath :config) "/spell")]
  (set! spellfile+ (.. spell-folder "/en.utf-8.add"))
  (set! spellfile+ (.. spell-folder "/es.utf-8.add")))

;; External configuration
(set! exrc)

;; Mouse support
(set! mouse :a)

;; True color
(set! termguicolors)

;; Line numbers
(set! number)
(set! relativenumber)

;; Scrolling
(set! splitkeep :screen)
(set! smoothscroll)

;; Command-line
(set! noshowmode)

;; Whitespace
(set! list)
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Sign column
(set! signcolumn "yes:1")

;; Insert-mode completion
(set! shortmess+ :c)

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")
