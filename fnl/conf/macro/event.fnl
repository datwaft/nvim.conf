(import-macros {: as->} :conf.macro.thread)

(local {: format} string)
(local {: insert
        : concat} table)

(local {: fn?
        : gensym-checksum
        : vlua} (require :conf.macro.helpers))

(fn last [xs]
  (. xs (length xs)))

(fn ->str [x]
  (tostring x))

(fn includes? [xs x]
  (accumulate [is? false
               _ v (ipairs xs)
               :until is?] (= v x)))

(lambda augroup! [name ...]
  "Defines an autocommand group using the vim API."
  `(do
     (vim.cmd ,(format "augroup %s" name))
     (vim.cmd "autocmd!")
     (do
       ,...)
     (vim.cmd "augroup END")))

(lambda buf-augroup! [name ...]
  "Defines a buffer-local autocommand group using the vim API."
  `(do
     (vim.cmd ,(format "augroup %s" name))
     (vim.cmd "autocmd! * <buffer>")
     (do
       ,...)
     (vim.cmd "augroup END")))

(lambda autocmd! [events pattern ...]
  "Defines an autocommand using the vim API."
  (let [events (as-> [$ events]
                     (if (sequence? $) $ [$])
                     (icollect [_ v (ipairs $)] (->str v))
                     (concat $ ","))
        pattern (as-> [$ pattern]
                      (if (sequence? $) $ [$])
                      (icollect [_ v (ipairs $)] (->str v))
                      (concat $ ","))
        once? (or (includes? [...] '++once)
                  (includes? [...] :++once))
        nested? (or (includes? [...] '++nested)
                    (includes? [...] :++nested))
        command (last [...])]
    (if (fn? command)
      (let [fsym (gensym-checksum "__" command)]
        `(do
           (global ,fsym ,command)
           (vim.cmd ,(format (if
                               (and once? nested?) "autocmd %s %s ++once ++nested call %s"
                               once? "autocmd %s %s ++once call %s"
                               nested? "autocmd %s %s ++nested call %s"
                               "autocmd %s %s call %s")
                             events pattern (vlua fsym)))))
      `(vim.cmd ,(format (if
                           (and once? nested?) "autocmd %s %s ++once ++nested %s"
                           once? "autocmd %s %s ++once %s"
                           nested? "autocmd %s %s ++nested %s"
                           "autocmd %s %s %s")
                         events pattern command)))))

{: augroup!
 : buf-augroup!
 : autocmd!}
