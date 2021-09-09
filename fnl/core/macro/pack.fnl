(local {: conj
        : nil?
        : empty?
        : vector
        : hash-map} (require :lib.cljlib))

(global core#pack (vector))

(fn pack [name options]
  (let [options (if (or (nil? options)
                        (empty? options)) (hash-map)
                  options)]
      (global core#pack (conj core#pack (conj options [1 name])))))

(fn unpack! []
  `((. (require :packer) :startup)
    #(do
       ,(unpack (icollect [_ plugin (ipairs core#pack)]
                  `(use ,plugin))))))

{: pack
 : unpack!}
