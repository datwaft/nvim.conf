(local {: conj
        : cons} (require :lib.cljlib))

(global core#pack [])

(fn pack [name options]
  "Adds a plugin to the list"
  (let [options (or options [])]
    (set core#pack (conj core#pack (cons name options)))))

(fn unpack! []
  `((. (require :packer) :startup)
    (unpack (icollect [_ plugin (ipairs core#pack)]
              `(use ,plugin)))))

{: pack
 : unpack!}
