(import-macros {: pack} :themis.pack)

(pack "eraserhd/parinfer-rust" {:build "cargo build --release"
                                :ft conf.lisp-filetypes})
