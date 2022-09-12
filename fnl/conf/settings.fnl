(import-macros {: let!} :themis.var)
(import-macros {: set!} :themis.opt)

(local {: byte} string)

(local {: stdpath
        : expand} vim.fn)

(fn executable? [...] (= 1 (vim.fn.executable ...)))

(fn escape [combination]
  (vim.api.nvim_replace_termcodes combination true true true))

;;; =========================
;;; Local variable definition
;;; =========================
; Define configuration folder
(local configuration-folder (stdpath :config))

;;; =========================
;;; Environment configuration
;;; =========================
; Define python binary
(let! python3_host_prog (if (executable? "python") (vim.fn.exepath "python")
                          (executable? "python3") (vim.fn.exepath "python3")
                          nil))
; Disable some providers
(let! loaded_ruby_provider 0)
(let! loaded_perl_provider 0)

;;; ====================
;;; Editor configuration
;;; ====================
;; File configuration
; Do not write backups
(set! nowritebackup)
; Do not create swap files
(set! noswapfile)

;; Indentation configuration
; Use spaces instead of tabs
(set! expandtab)
; Number of spaces used for each <tab> and auto-indent
(set! softtabstop -1)
(set! shiftwidth 0)
(set! tabstop 2)

;; Wrapping configuration
; Do not break words at the middle
(set! linebreak)
; Maintain indentation on break
(set! breakindent)
; Add characters after wrap
(set! breakindentopt ["shift:2"])
; Show character after wrap
(set! showbreak "↳ ")

;; Formatting configuration
(set! formatoptions [:q :j])

;; Spell-checking configuration
(set! spell)
(set! spelllang [:en])
(set! spelloptions [:camel])

;; Undo persistence
(set! undodir (.. configuration-folder "/undodir.nvim"))
(set! undofile)

;; CursorHold delay
(set! updatetime 500)

;;; ======================
;;; Terminal configuration
;;; ======================
;; Mouse support
(set! mouse :a)

;;; ====================
;;; Visual configuration
;;; ====================
;; True color
(set! termguicolors)

;; Pseudo-transparecy for floating windows
(set! winblend 10)
(set! pumblend 10)

;; Line number
(set! number)
(set! relativenumber)

;; Status configuration
(set! noshowmode)

;; Characters configuration
; Show whitespace characters
(set! list)
; Define characters to show
(set! listchars {:trail "·"
                 :tab "→ "
                 :nbsp "·"})

;; Sign column
; Always show sign column
(set! signcolumn "yes:1")

;; Fold configuration
; Enable folding
(set! foldenable)
; Display column for folds
(set! foldcolumn "1")
; Fold column characters
(set! fillchars {:eob " "
                 :fold " "
                 :foldopen ""
                 :foldsep " "
                 :foldclose ""})
; Start with everything unfolded
(set! foldlevelstart 99)

;;; ========================
;;; Completion configuration
;;; ========================
;; Insert-mode completion
(set! infercase)
(set! shortmess+ :c)

;; Command-mode completion
(set! wildcharm (byte (escape "<tab>")))
(set! wildignorecase)

;; Support fuzzy finding
(set! path ["." "**"])

;;; ==========================
;;; Command-mode configuration
;;; ==========================
;; Search and replace
(set! ignorecase)
(set! smartcase)

;; Substitution
(set! gdefault)

;;; ===================
;;; NETRW configuration
;;; ===================
;; Disable banner
(let! netrw_banner 0)
;; Tree style listing
(let! netrw_liststyle 3)
;; Open files in the previous window
(let! netrw_browse_split 4)
;; Open split to the right
(let! netrw_altv 1)
;; Set split size
(let! netrw_winsize 20)
;; Start with dotfiles hidden
(let! netrw_list_hide "\\(^\\|\\s\\s\\)\\zs\\.\\S\\+")

;;; ===========================
;;; Miscellaneous configuration
;;; ===========================
;; Diff-mode
(set! diffopt [:filler :internal :indent-heuristic :algorithm:histogram])

;; Lazy redraw
(set! lazyredraw)

;; Timeout for mappings
(set! timeoutlen 500)

;; LocalLeader
(let! maplocalleader (escape "<space>"))

;; Markdown
(let! markdown_fenced_languages ["ts=typescript"])

;; Grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")

;;; ===========================================
;;; Override configuration for floating windows
;;; ===========================================
(let [original vim.lsp.util.open_floating_preview]
  (fn vim.lsp.util.open_floating_preview [...]
    (let [(bufnr winid) (original ...)]
      (vim.api.nvim_win_set_option winid :breakindentopt "")
      (vim.api.nvim_win_set_option winid :showbreak "NONE"))))
