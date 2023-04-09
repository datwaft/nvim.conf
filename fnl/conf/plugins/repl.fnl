(import-macros {: pack} :themis.pack.lazy)

[;; SLIME
 (pack "jpalardy/vim-slime" {:init (fn []
                                     ;; Variables
                                     (import-macros {: let!} :themis.var)
                                     (let! slime_target "tmux")
                                     (let! slime_default_config {:socket_name "default"
                                                                 :target_pane "{last}"})
                                     (let! slime_dont_ask_default 1)
                                     (let! slime_no_mappings 1)
                                     ;; Mappings
                                     (import-macros {: map!} :themis.keybind)
                                     (map! [x] "<C-c><C-c>" "<plug>SlimeRegionSend")
                                     (map! [n] "<C-c><C-c>" "<plug>SlimeParagraphSend"))})
 ;; Interactive evaluation for LISP
 (pack "Olical/conjure" {:ft conf.lisp-filetypes
                         :init #(do (import-macros {: let!} :themis.var)
                                  ;; Set client for scheme
                                  (let! conjure#filetype#scheme "conjure.client.guile.socket"))})
 ;; Clojure interactive evaluation
 (pack "clojure-vim/vim-jack-in" {:ft "clojure"
                                  :dependencies ["tpope/vim-dispatch"
                                                 "radenling/vim-dispatch-neovim"]})]
