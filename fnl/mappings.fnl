;; Set localleader
(let! maplocalleader (vim.api.nvim_replace_termcodes "<space>" true true true))

;; Disable highlight with <ESC>
(map! [n] "<esc>" "<esc><cmd>nohlsearch<cr>")

;; Make `/` and `?` search inside selection
(map! [x] "/" "<esc>/\\%V")
(map! [x] "?" "<esc>?\\%V")

;; Open or focus the quickfix window
(map! [n] "<leader>q" "<cmd>copen<cr>")

;; Close the quickfix window
(map! [n] "<leader>Q" "<cmd>cclose<cr>")

;; Create a new tab page
(map! [n] "<C-t>n" "<cmd>tabnew<cr>")

;; List tabs
(map! [n] "<C-t>s" "<cmd>tabs<cr>")

;; Navigate to the next tab page
(map! [n] "<C-t>]" "<cmd>tabNext<cr>")

;; Navigate to the previous tab page
(map! [n] "<C-t>[" "<cmd>tabprevious<cr>")

;; Kill current tab page
(map! [n] "<C-t>w" "<cmd>tabclose<cr>")
(map! [n] "<C-t>q" "<cmd>tabclose<cr>")

;; Close wildmenu using <space>
(let [wildmenumode? (fn [...] (= (vim.fn.wildmenumode ...) 1))]
  (map! [c] "<space>" #(if (wildmenumode?) "<C-y>" "<space>") {:expr true}))

;; Line text objects
(map! [xo] "il" ":<C-u>normal! g_v^<cr>"
      {:silent true})
(map! [xo] "al" ":<C-u>normal! $v0<cr>"
      {:silent true})

;; Document text objects
(map! [x] "id" ":<C-u>normal! G$Vgg0<cr>"
      {:silent true})
(map! [o] "id" ":<C-u>normal! GVgg<cr>"
      {:silent true})
