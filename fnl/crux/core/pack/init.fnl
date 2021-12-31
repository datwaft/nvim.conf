(import-macros {: pack
                : pack!
                : rock!
                : unpack!} :crux.lib.macro.pack)

;;; Essential
;; Plugin Manager
(pack! "wbthomason/packer.nvim")
;; Using Fennel for configuration
(pack! "rktjmp/hotpot.nvim")

;;; Aesthetic
;; Colorscheme
(pack! "wuelnerdotexe/vim-enfocado" {:as "colorscheme"
                                     :req "colorscheme"})
;; Statusline
(pack! "famiu/feline.nvim" {:req "feline"})
;; Treesitter
(pack! "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"
                                          :req "treesitter"
                                          :requires ["p00f/nvim-ts-rainbow"
                                                     "nvim-treesitter/nvim-treesitter-refactor"
                                                     "JoosepAlviste/nvim-ts-context-commentstring"]})
;; Treesitter-powered spelling
(pack! "lewis6991/spellsitter.nvim" {:init "spellsitter"
                                     :requires ["nvim-treesitter/nvim-treesitter"]})
;; Preview substitution
(pack! "markonm/traces.vim")
;; Color code highlight
(pack! "rrethy/vim-hexokinase" {:run "make hexokinase"
                                :req "hexokinase"})
;; Indent lines
(pack! "lukas-reineke/indent-blankline.nvim" {:req "indent-blankline"})
;; Developer icons
(pack! "kyazdani42/nvim-web-devicons" {:req "devicons"})
;; Highlight matches
(pack! "kevinhwang91/nvim-hlslens" {:req "hlslens"})

;;; Text objects
;; General
(pack! "wellle/targets.vim")
;; Indent-level text object
(pack! "michaeljsmith/vim-indent-object")
;; CamelCase text objects
(pack! "bkad/CamelCaseMotion" {:req "camel-case-motion"})
;; Whitespace text objects
(pack! "vim-utils/vim-space")

;;; Actions
;; Comment
(pack! "numToStr/Comment.nvim" {:init "Comment"})
;; Surround
(pack! "machakann/vim-sandwich")
;; Increment and decrement numbers
(pack! "zegervdv/nrpattern.nvim" {:requires ["tpope/vim-repeat"]
                                  :init "nrpattern"})

;;; Commands
;; Subversion and Coercion
(pack! "tpope/vim-abolish")
;; Undo-tree
(pack! "mbbill/undotree")
;; Upload to a paste bin
(pack! "rktjmp/paperplanes.nvim" {:req "paperplanes"})

;;; Enhancement
;; Matching words/parentheses
(pack! "andymass/vim-matchup")
;; Autopairs
(pack! "windwp/nvim-autopairs" {:req "autopairs"})
;; Quickfix
(pack! "kevinhwang91/nvim-bqf")
;; Mapping
(pack! "folke/which-key.nvim" {:req "which-key"})
;; Wildmenu
(pack! "gelguy/wilder.nvim" {:run ":UpdateRemotePlugins"
                             :req "wilder"})
;; Stabilization
(pack! "luukvbaal/stabilize.nvim" {:init "stabilize"})

;;; Text Editing
;; Parentheses Inference
(pack! "eraserhd/parinfer-rust" {:run "cargo build --release"
                                 :ft [:fennel :clojure :lisp]})
;; Completion
(pack! "hrsh7th/nvim-cmp" {:req "cmp"
                           :requires ["hrsh7th/cmp-nvim-lsp"
                                      "hrsh7th/cmp-buffer"
                                      "hrsh7th/cmp-path"
                                      "andersevenrud/cmp-tmux"
                                      (pack "hrsh7th/cmp-vsnip" {:requires "hrsh7th/vim-vsnip"})
                                      "lukas-reineke/cmp-under-comparator"]})
;; Snippets
(pack! "hrsh7th/vim-vsnip" {:req "vsnip"
                            :requires ["rafamadriz/friendly-snippets"]})

;;; REPL
;; Lisp REPL
(pack! "Olical/conjure" {:req "conjure"
                         :ft [:fennel :clojure :lisp]})
;; General REPL-like
(pack! "michaelb/sniprun" {:run "bash install.sh"
                           :req "sniprun"
                           :requires ["rcarriga/nvim-notify"]
                           :ft [:sh :c :cpp :go :java :javascript :typescript
                                :lua :markdown :perl :python :r :ruby :rust
                                :scala :julia]})

;;; Integration
;; Git
(pack! "lewis6991/gitsigns.nvim" {:init "gitsigns"
                                  :requires ["nvim-lua/plenary.nvim"]})
(pack! "lambdalisue/gina.vim")
;; Tmux
(pack! "aserowy/tmux.nvim" {:req "tmux"})
;; nnn
(pack! "mcchrish/nnn.vim" {:req "nnn"})
;; Glow
(pack! "ellisonleao/glow.nvim" {:run ":GlowInstall"
                                :req "glow"
                                :ft [:markdown]})

;;; Files and directories
;; Fuzzy Finder
(pack! "nvim-telescope/telescope.nvim" {:req "telescope"
                                        :requires ["nvim-lua/popup.nvim"
                                                   "nvim-lua/plenary.nvim"
                                                   "nvim-telescope/telescope-fzy-native.nvim"]})
;; File explorer
(pack! "kyazdani42/nvim-tree.lua" {:as "file-explorer"
                                   :req "file-explorer"})

;;; Language Server Protocol (LSP)
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
;; Rename
(pack! "filipdutescu/renamer.nvim" {:req "renamer"
                                    :requires ["nvim-lua/plenary.nvim"]})
;; Code Actions menu
(pack! "weilbith/nvim-code-action-menu" {:cmd "CodeActionMenu"})
;; Integrate with non-LSP
(pack! "jose-elias-alvarez/null-ls.nvim" {:req "null-ls"
                                          :requires ["nvim-lua/plenary.nvim"
                                                     "neovim/nvim-lspconfig"]})

;;; Debug Adapter Protocol (DAP)
(pack! "mfussenegger/nvim-dap" {:run ":helptags ALL"
                                :req "dap"})
(pack! "rcarriga/nvim-dap-ui" {:req "dap-ui"
                               :requires ["mfussenegger/nvim-dap"]})
(pack! "mfussenegger/nvim-dap-python" {:req "dap-python"
                                       :requires ["mfussenegger/nvim-dap"]})

;;; Filetypes
;; Fennel
(pack! "bakpakin/fennel.vim" {:ft [:fennel]})
;; Git
(pack! "tpope/vim-git")
(pack! "gisphm/vim-gitignore")
;; Kitty
(pack! "fladson/vim-kitty")
;; Markdown
(pack! "plasticboy/vim-markdown" {:requires ["godlygeek/tabular"]})

;;; --------------------

; Initialize declared plugins
(unpack!)
