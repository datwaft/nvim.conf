(local {: conj
        : nil?
        : empty?
        : vector
        : hash-map} (require :lib.cljlib))

(global core#pack (vector))

(fn pack [name options]
  "Returns a plugin with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (let [options (if (or (nil? options)
                        (empty? options)) (hash-map)
                  options)]
    (conj options [1 name])))

(fn pack! [name options]
  "Declares a plugin with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (global core#pack (conj core#pack (pack name options))))

(fn unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  `((. (require :packer) :startup)
    #(do
       ,(unpack (icollect [_ plugin (ipairs core#pack)]
                  `(use ,plugin))))))

{: pack
 : pack!
 : unpack!}
