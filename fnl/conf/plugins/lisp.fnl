(import-macros {: pack} :themis.pack.lazy)

[;; Parentheses inference
 (pack "eraserhd/parinfer-rust" {:build "cargo build --release"
                                 :ft conf.lisp-filetypes})]
