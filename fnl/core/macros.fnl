; Use the globals inside the macros
(require :core.globals)

(global __core_symfn_id 0)
(fn gensym-fn! []
  (.. "__core_symfn_"
      (do
        (global __core_symfn_id (inc __core_symfn_id))
        __core_symfn_id)))

(fn get? [name]
  (let [name (tostring name)
        name (if (= (name:sub 1 2) "no") (name:sub 3) name)]
    `(let [(ok?# value#) (pcall #(: (. vim.opt ,name) :get))]
       (if ok?# value# nil))))

(fn get-local? [name]
  (let [name (tostring name)
        name (if (= (name:sub 1 2) "no") (name:sub 3) name)]
    `(let [(ok?# value#) (pcall #(: (. vim.opt_local ,name) :get))]
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
    (if (and 
          (list? value)
          (or
            (= (tostring (head value)) :hashfn)
            (= (tostring (head value)) :fn)))
      (let [symbol (gensym-fn!)]
        `(tset vim.opt ,name (do
                               (global ,(sym symbol) ,value)
                               ,(.. "v:lua." symbol "()"))))
      (match name-last-character
        "?" `(get? ,name-without-last-character)
        "!" `(tset vim.opt ,name-without-last-character
                   (not (get? ,name-without-last-character)))
        "+" `(: (. vim.opt ,name-without-last-character) :append ,value)
        "-" `(: (. vim.opt ,name-without-last-character) :remove ,value)
        "^" `(: (. vim.opt ,name-without-last-character) :prepend ,value)
        _ `(tset vim.opt ,name ,value)))))

(fn set-local! [name value]
  "Set vim option with vim.opt_local"
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
    (if (and 
          (list? value)
          (or
            (= (tostring (head value)) :hashfn)
            (= (tostring (head value)) :fn)))
      (let [symbol (gensym-fn!)]
        `(tset vim.opt_local ,name (do
                                     (global ,(sym symbol) ,value)
                                     ,(.. "v:lua." symbol "()"))))
      (match name-last-character
        "?" `(get? ,name-without-last-character)
        "!" `(tset vim.opt_local ,name-without-last-character
                   (not (get? ,name-without-last-character)))
        "+" `(: (. vim.opt_local ,name-without-last-character) :append ,value)
        "-" `(: (. vim.opt_local ,name-without-last-character) :remove ,value)
        "^" `(: (. vim.opt_local ,name-without-last-character) :prepend ,value)
        _ `(tset vim.opt_local ,name ,value)))))

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
     (do
       ,...)
     (vim.cmd "augroup END")
     nil))

(fn autocmd! [events pattern command]
  (let [events (join "," (totable (map tostring (if (sequence? events) events [events]))))
        pattern (join "," (totable (map tostring (if (sequence? pattern) pattern [pattern]))))]
    (if (string? command)
      `(vim.cmd ,(.. "autocmd " events " " pattern " " command))
      (let [name (gensym-fn!)]
        `(vim.cmd (..
                    ,(.. "autocmd " events " " pattern " ")
                    (do
                      (global ,(sym name) ,command)
                      ,(.. "call v:lua." name "()"))))))))

{: gensym-fn!
 : get?
 : get-local?
 : set!
 : set-local!
 : let!
 : augroup!
 : autocmd!}
