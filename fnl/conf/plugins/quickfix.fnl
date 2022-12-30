(import-macros {: pack} :themis.pack.lazy)

[;; General enhancement
 (pack "kevinhwang91/nvim-bqf" {:ft "qf"
                                :dependencies ["junegunn/fzf"
                                               "nvim-treesitter/nvim-treesitter"]})
 ;; Aesthetic enhancement
 {:url "git@gitlab.com:yorickpeterse/nvim-pqf.git" :config true}]
