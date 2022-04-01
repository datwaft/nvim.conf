(local {: format} string)
(local {: insert} table)

(fn str? [x]
  (= :string (type x)))

(fn tbl? [x]
  (= :table (type x)))

(fn nil? [x]
  (= nil x))

(global conf/pack [])
(global conf/rock [])

(lambda pack [identifier ?options]
  "Returns a mixed table with the identifier as the first sequential element
  and options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (if
                    (= k :req) (values :config (format "require('conf.pack.%s')" v))
                    (= k :init) (values :config (format "require('%s').setup()" v))
                    (values k v)))]
    (doto options
          (tset 1 identifier))))

(lambda pack! [identifier ?options]
  "Declares a plugin with its options.
  This is a mixed table saved on the global compile-time variable conf/pack.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (insert conf/pack (pack identifier ?options)))

(lambda rock [identifier ?options]
  "Returns a mixed table with the identifier as the first sequential element
  and options as hash-table items.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (let [options (or ?options {})]
    (doto options
          (tset 1 identifier))))

(lambda rock! [identifier ?options]
  "Declares a plugin with its options.
  This is a mixed table saved on the global compile-time variable conf/rock.
  See https://github.com/wbthomason/packer.nvim for information about the
  options."
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (nil? ?options) (tbl? ?options))
                  "expected table for options" ?options)
  (insert conf/rock (rock identifier ?options)))

(lambda unpack! []
  "Initializes the plugin manager with the previously declared plugins and
  their options."
  (let [packs (icollect [_ v (ipairs conf/pack)]
                `(use ,v))
        rocks (icollect [_ v (ipairs conf/rock)]
                `(use_rocks ,v))]
    `((. (require :packer) :startup)
      #(do
         ,(unpack (icollect [_ v (ipairs packs) :into rocks] v))))))

{: pack
 : pack!
 : rock
 : rock!
 : unpack!}
