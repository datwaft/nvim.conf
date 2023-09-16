(fn config []
  (local capabilities (require :language-server.capabilities))

  (local lsp (require :lspconfig))

  ;; Configure some language servers with the default configuration
  (let [servers [:bashls :clangd :clojure_lsp :cmake :cssls :dockerls
                 :emmet_ls :eslint :gopls :hls :html :jdtls :jsonls
                 :lemminx :lua_ls :r_language_server :rnix :ruby_ls
                 :rust_analyzer :svelte :taplo :vimls :volar :yamlls
                 :zls]]
    (each [_ server (ipairs servers)]
      ((. lsp server :setup) {: capabilities})))

  ;; Python
  (lsp.pylsp.setup
    {: capabilities
     :settings {:pylsp {:plugins {;; Formatting
                                  :black {:enabled true}
                                  :autopep8 {:enabled false}
                                  :yapf {:enabled false}
                                  ;; Linting
                                  :pylint {:enabled true
                                           :executable "pylint"}
                                  :pyflakes {:enabled false}
                                  :pycodestyle {:enabled false}
                                  ;; Typing
                                  :pylsp_mypy {:enabled true}
                                  ;; Auto-completion
                                  :jedi_completion {:fuzzy true}
                                  ;; Import sorting
                                  :pyls_isort {:enabled true}}}}})
  ;; JSON
  (let [schemastore (require :schemastore)]
    (lsp.jsonls.setup
      {: capabilities
       :settings {:json {:schemas (schemastore.json.schemas)
                         :validate {:enable true}}}})))

[;; Configuration
 (pack "neovim/nvim-lspconfig"
       {: config
        :dependencies [(pack "j-hui/fidget.nvim" {:config true :tag "legacy"})
                       "b0o/schemastore.nvim"]})
 ;; Typescript
 (pack "pmizio/typescript-tools.nvim"
       {:dependencies ["nvim-lua/plenary.nvim"
                       "neovim/nvim-lspconfig"]
        :config true})
 ;; Dim unused elements
 (pack "zbirenbaum/neodim" {:event "LspAttach"
                            :opts {:alpha 0.6
                                   :blend_color "#1e1e2e"}})
 ]
