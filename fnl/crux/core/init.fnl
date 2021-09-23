(import-macros {: pack!
                : rock!
                : unpack!} :crux.lib.macro.pack)

(local {: vector
        : filter
        : every?
        : complement} (require :cljlib))
(local {: exists?} (require :crux.lib.module))
(local {: warn!} (require :crux.lib.io))
(local {: format} string)

(local requirements (vector
                      :rex_pcre2))

(if (not (every? exists? requirements))
  (do
    (each [_ name (ipairs (filter (complement exists?) requirements))]
      (warn! (format "Module `%s` was not found." name)))
    (warn! "Please execute :PackerSync to install the missing modules")

    (pack! "wbthomason/packer.nvim")
    (pack! "rktjmp/hotpot.nvim")
    (rock! "lrexlib-pcre2")
    (unpack!))
  (do
    (require :crux.core.pack)
    (require :crux.core.settings)
    (require :crux.core.events)
    (require :crux.core.keybinds)
    (require :crux.core.lsp)))
