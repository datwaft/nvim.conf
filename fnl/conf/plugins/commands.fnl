(import-macros {: pack} :themis.pack.lazy)

[;; Subversion and Coercion
 "tpope/vim-abolish"
 ;; Undo-Tree
 "mbbill/undotree"
 ;; Upload to paste-bin
 (pack "rktjmp/paperplanes.nvim" {:opts {:register "+"
                                         :provider "0x0.st"}})
 ;; Run tests
 (pack "echasnovski/mini.test" {:config #((. (require :mini.test) :setup))})]
