; Use the globals inside the macros
(require :core.globals)

(fn augroup [name ...]
  "Create an augroup for your autocmds"
  `(do
     (vim.cmd (.. "augroup " ,(tostring name) "\nautocmd!"))
     ,...
     (vim.cmd "augroup END")
     nil))

(fn get? [name]
  (let [name (tostring name)
        name (if (= (name:sub 1 2) "no") (name:sub 3) name)]
    `(let [(ok?# value#) (pcall #(: (. vim.opt ,name) :get))]
       (if ok?# value# nil))))

(fn set! [name value]
  "Set vim option with vim.opt"
  (let [name (tostring name)
        value-is-nil? (nil? value)
        name-begins-with-no? (= (name:sub 1 2) "no")
        name (if (and value-is-nil? name-begins-with-no?)
               (name:sub 3)
               name)
        value (if value-is-nil?
                (not name-begins-with-no?)
                value)
        name-last-character (name:sub -1)
        name-without-last-character (name:sub 1 -2)]
    (match name-last-character
      "?" `(get? ,name-without-last-character)
      "!" `(tset vim.opt ,name-without-last-character
                 (not (get? ,name-without-last-character)))
      "+" `(: (. vim.opt ,name-without-last-character) :append ,value)
      "-" `(: (. vim.opt ,name-without-last-character) :remove ,value)
      "^" `(: (. vim.opt ,name-without-last-character) :prepend ,value)
      _ `(tset vim.opt ,name ,value))))

(fn let! [name value]
  "Set vim variable with vim.[g b w t]"
  (let [name (tostring name)
        scope (if (any #(= $ (name:sub 1 2)) ["g/" "b/" "w/" "t/"])
                (name:sub 1 1)
                nil)
        name (if (nil? scope) name (name:sub 3))]
    (match scope
      "g" `(tset vim.g ,name ,value)
      "b" `(tset vim.b ,name ,value)
      "w" `(tset vim.w ,name ,value)
      "t" `(tset vim.t ,name ,value)
      _ `(tset vim.g ,name ,value))))

{: augroup
 : get?
 : set!
 : let!}
