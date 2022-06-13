(import-macros {: pack
                : pack! : unpack!} :themis.pack)

(local lisp-ft [:fennel
                :clojure
                :lisp
                :racket
                :scheme])

;;; ==========
;;; Essentials
;;; ==========
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel to configure neovim
(pack! "rktjmp/hotpot.nvim")
;; Dynamic LISP evaluation
(pack! "Olical/conjure")
;; Macros
(pack! "datwaft/themis.nvim")

;;; =========
;;; Aesthetic
;;; =========
;; Colorscheme
(pack! "wuelnerdotexe/vim-enfocado" {:as "colorscheme"
                                     :require* "conf.pack.colorscheme"})
;; Statusline
(pack! "feline-nvim/feline.nvim" {:require* "conf.pack.feline"})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                          :require* "conf.pack.treesitter"
                                          :requires ["p00f/nvim-ts-rainbow"
                                                     "nvim-treesitter/nvim-treesitter-refactor"
                                                     "JoosepAlviste/nvim-ts-context-commentstring"]})
;; Dim unused variables and functions
(pack! "narutoxy/dim.lua" {:setup* "dim"
                           :requires ["nvim-treesitter/nvim-treesitter"
                                      "neovim/nvim-lspconfig"]})
;; Preview substitution
(pack! "markonm/traces.vim" {:require* "conf.pack.traces"})
;; Color code highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :require* "conf.pack.hexokinase"})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:require* "conf.pack.indent-blankline"})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:require* "conf.pack.devicons"})
;; Highlight matches
(pack! "kevinhwang91/nvim-hlslens" {:require* "conf.pack.hlslens"})

;;; ============
;;; Text objects
;;; ============
;; General
(pack! "wellle/targets.vim")
;; Indent-level text objects
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:require* "conf.pack.camel-case-motion"})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; =======
;;; Actions
;;; =======
;; Comment
(pack! "numToStr/Comment.nvim" {:setup* "Comment"})
;; Surround
(pack! "machakann/vim-sandwich")
;; Increment and decrement numbers
(pack! "zegervdv/nrpattern.nvim" {:requires ["tpope/vim-repeat"]
                                  :setup* "nrpattern"})

;;; ========
;;; Commands
;;; ========
;; Subversion and Coercion
(pack! "tpope/vim-abolish")
;; Undo-tree
(pack! "mbbill/undotree")
;; Upload to a paste bin
(pack! "rktjmp/paperplanes.nvim" {:require* "conf.pack.paperplanes"})

;;; ===========
;;; Enhancement
;;; ===========
;; Conflicts
(pack! "rhysd/conflict-marker.vim")
;; Quickfix
(pack! "kevinhwang91/nvim-bqf")
;; Create missing directories on save
(pack! "jghauser/mkdir.nvim" {:require* "mkdir"})
;; Stabilization
(pack! "luukvbaal/stabilize.nvim" {:setup* "stabilize"})
;; Terminal
(pack! "voldikss/vim-floaterm" {:require* "conf.pack.floaterm"})
;; Sorting
(pack! "sQVe/sort.nvim" {:setup* "sort"})

;;; ============
;;; Text Editing
;;; ============
;; Parentheses inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft lisp-ft})
;; Completion
(pack! "hrsh7th/nvim-cmp" {:require* "conf.pack.cmp"
                           :requires ["hrsh7th/cmp-nvim-lsp"
                                      "hrsh7th/cmp-buffer"
                                      "hrsh7th/cmp-path"
                                      "andersevenrud/cmp-tmux"
                                      (pack "hrsh7th/cmp-vsnip" {:requires "hrsh7th/vim-vsnip"})
                                      "lukas-reineke/cmp-under-comparator"]})
;; Snippets
(pack! "hrsh7th/vim-vsnip" {:require* "conf.pack.vsnip"
                            :requires ["rafamadriz/friendly-snippets"]})
;; Emmet
(pack! "mattn/emmet-vim" {:require* "conf.pack.emmet"})

;;; ===========
;;; Integration
;;; ===========
;; Sudo
(pack! "lambdalisue/suda.vim" {:require* "conf.pack.suda"})
;; Git
(pack! "lewis6991/gitsigns.nvim" {:require* "conf.pack.gitsigns"
                                  :requires ["nvim-lua/plenary.nvim"]})
(pack! "lambdalisue/gina.vim")
;; TMUX
(pack! "aserowy/tmux.nvim" {:require* "conf.pack.tmux"})
;; Browsers
(pack! "glacambre/firenvim" {:run #(vim.fn.firenvim#install 0)})
;; Conjure with Clj
(pack! "clojure-vim/vim-jack-in" {:requires ["tpope/vim-dispatch"
                                             "radenling/vim-dispatch-neovim"]})

;;; ==========
;;; Filesystem
;;; ==========
;; Fuzzy Finder
(pack! "nvim-telescope/telescope.nvim" {:require* "conf.pack.telescope"
                                        :requires ["nvim-lua/popup.nvim"
                                                   "nvim-lua/plenary.nvim"
                                                   "nvim-telescope/telescope-fzy-native.nvim"
                                                   (pack "nvim-telescope/telescope-smart-history.nvim" {:requires ["tami5/sqlite.lua"]})]})
;; Filesystem editing
(pack! "elihunter173/dirbuf.nvim")

;;; =======
;;; Preview
;;; =======
;; PlantUML
(pack! "weirongxu/plantuml-previewer.vim" {:requires ["tyru/open-browser.vim"]
                                           :ft [:plantuml]})
;; Markdown
(pack! "ellisonleao/glow.nvim" {:require* "conf.pack.glow"
                                :ft [:markdown]})

;;; =========
;;; Filetypes
;;; =========
;; Fennel
(pack! "Olical/aniseed")
;; Git
(pack! "tpope/vim-git")
(pack! "gisphm/vim-gitignore")
;; Kitty
(pack! "fladson/vim-kitty")
;; PlantUML
(pack! "aklt/plantuml-syntax")
;; Corpus
(pack! "datwaft/corpus.vim")
;; Tmux
(pack! "tmux-plugins/vim-tmux")
;; Just
(pack! "NoahTheDuke/vim-just")
;; Svelte
(pack! "evanleck/vim-svelte" {:requires ["othree/html5.vim"
                                         "pangloss/vim-javascript"]})

;;; ==============================
;;; Language Server Protocol (LSP)
;;; ==============================
;; Configuration
(pack! "neovim/nvim-lspconfig")
;; Lua Neovim Development
(pack! "folke/lua-dev.nvim")
;; SchemaStore
(pack! "b0o/schemastore.nvim")
;; Extensions
(pack! "nvim-lua/lsp_extensions.nvim")
;; Signature
(pack! "ray-x/lsp_signature.nvim")
;; Integrate with non-LSP
(pack! "jose-elias-alvarez/null-ls.nvim" {:require* "conf.pack.null-ls"
                                          :requires ["nvim-lua/plenary.nvim"
                                                     "neovim/nvim-lspconfig"]})
;; Report progress
(pack! "j-hui/fidget.nvim" {:setup* "fidget"})

;;; ==========
(unpack!)
