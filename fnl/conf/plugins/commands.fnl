(import-macros {: pack} :themis.pack.lazy)

[;; Subversion and Coercion
 "tpope/vim-abolish"
 ;; Undo-Tree
 "mbbill/undotree"
 ;; Upload to paste-bin
 (pack "rktjmp/paperplanes.nvim" {:config {:register "+"
                                           :provider "0x0.st"}})
 ;; Create snippet
 (pack "krivahtoo/silicon.nvim" {:build "./install.sh build"
                                 :config #(let [silicon (require :silicon)]
                                            (silicon.setup {:font "JetBrains Mono=31"
                                                            :theme "Monokai Extended"
                                                            :background "#fff0"
                                                            :line_number true}))})
 ;; Run tests
 (pack "echasnovski/mini.test" {:config #((. (require :mini.test) :setup))})]
