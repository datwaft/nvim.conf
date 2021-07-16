; Use the globals inside the macros
(require :core.globals)

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

(fn augroup! [name ...]
  `(do
     (vim.cmd (.. "augroup " ,(tostring name) "\nautocmd!"))
     ,...
     (vim.cmd "augroup END")
     nil))

(global __autocmd_id 0)
(fn autocmd! [events pattern command]
  (let [events (join "," (totable (map tostring (if (sequence? events) events [events]))))
        pattern (join "," (totable (map tostring (if (sequence? pattern) pattern [pattern]))))]
    (if (string? command)
      `(vim.cmd ,(.. "autocmd " events " " pattern " " command))
      (let [name (.. "__autocmd_"
                     (do
                       (global __autocmd_id (inc __autocmd_id))
                       __autocmd_id))]
        `(vim.cmd (..
                    ,(.. "autocmd " events " " pattern " ")
                    (do
                      (global ,(sym name) ,command)
                      ,(.. "call v:lua." name "()"))))))))

{: get?
 : set!
 : let!
 : augroup!
 : autocmd!}
