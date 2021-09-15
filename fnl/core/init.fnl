(local {: vector
        : filter
        : every?
        : complement} (require :cljlib))
(local {: module#exists?} (require :core.utils.core))
(local {: warn!} (require :core.utils.io))

(import-macros {: pack!
                : rock!
                : unpack!} :core.macro.pack)

(local requirements (vector
                      :rex_pcre2))

(if (not (every? module#exists? requirements))
  (do
    (each [_ name (ipairs (filter (complement module#exists?) requirements))]
      (warn! (string.format "Module `%s` was not found." name)))
    (warn! "Please execute :PackerSync to install the missing modules")

    (pack! :wbthomason/packer.nvim)
    (pack! :rktjmp/hotpot.nvim)
    (rock! :lrexlib-pcre2)
    (unpack!))
  (do
    (require :core.plugin)
    (require :core.settings)))
