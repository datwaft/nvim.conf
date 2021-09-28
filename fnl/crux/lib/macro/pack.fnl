(local {: vector
        : hash-map
        : nil?
        : empty?
        : conj
        : concat
        : mapv} (require :cljlib))
(local {: format} string)

(global core/pack (vector))
(global core/rock (vector))

(fn pack [name ?options]
  "Returns a mixed table with a plugin as the first sequential and the options
  as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (let [options (if (or (nil? ?options)
                        (empty? ?options)) (hash-map)
                  (collect [k v (pairs ?options)]
                           (if
                             (= k :req) (values :config (format "require('crux.core.pack.%s')" v))
                             (= k :init) (values :config (format "require('%s').init()" v))
                             (values k v))))]
    (conj options [1 name])))

(fn pack! [name ?options]
  "Declares a plugin with its options.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (global core/pack (conj core/pack (pack name ?options))))

(fn rock [name ?options]
  "Returns a mixed table with a rock as the first sequential and the options
  as hash-table items.
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
  (global core/rock (conj core/rock (rock name ?options))))

(fn unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  `((. (require :packer) :startup)
    #(do
       ,(unpack (concat
                  (mapv #`(use_rocks ,$) core/rock)
                  (mapv #`(use ,$) core/pack))))))

{: pack
 : pack!
 : rock
 : rock!
 : unpack!}
