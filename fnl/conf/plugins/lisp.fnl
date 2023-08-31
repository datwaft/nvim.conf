(import-macros {: pack} :themis.pack.lazy)

[;; Parentheses inference
 (pack "eraserhd/parinfer-rust" {:build "cargo build --release"
                                 :ft (icollect [_ filetype (ipairs conf.lisp-filetypes)] (when (not= filetype :clojure) filetype))})
 ;; Paredit
 (pack "julienvincent/nvim-paredit" {:config true})]
