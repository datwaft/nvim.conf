(import-macros {: pack} :themis.pack.lazy)

(pack "catppuccin/nvim" {:name "catppuccin"
                         :config #(vim.cmd.colorscheme "catppuccin")})
