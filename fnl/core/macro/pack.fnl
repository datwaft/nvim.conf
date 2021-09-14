(local {: conj
        : concat
        : nil?
        : empty?
        : vector
        : hash-map} (require :cljlib))

(global core#pack (vector))
(global core#rock (vector))

(fn pack [name ?options]
  "Returns a plugin with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (let [options (if (or (nil? ?options)
                        (empty? ?options)) (hash-map)
                  ?options)]
    (conj options [1 name])))

(fn pack! [name ?options]
  "Declares a plugin with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (global core#pack (conj core#pack (pack name ?options))))

(fn rock [name ?options]
  "Returns a rock with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (let [options (if (or (nil? ?options)
                        (empty? ?options)) (hash-map)
                  ?options)]
    (conj options [1 name])))

(fn rock! [name ?options]
  "Declares a rock with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (global core#rock (conj core#rock (rock name ?options))))

(fn unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  `((. (require :packer) :startup)
    #(do
       ,(unpack (concat (icollect [_ rock (ipairs core#rock)]
                          `(use_rocks ,rock))
                        (icollect [_ pack (ipairs core#pack)]
                          `(use ,pack)))))))

{: pack
 : pack!
 : rock!
 : unpack!}
