(import-macros {: pack} :themis.pack)

(pack "catppuccin/nvim" {:name "catppuccin"
                         :config #(vim.cmd.colorscheme "catppuccin")})
