(local {: fn?} (require :conf.macro.helpers))

(local {: format} string)

(fn empty? [xs]
  (= 0 (length xs)))

(fn nil? [x]
  (= nil x))

(fn str? [x]
  (= :string (type x)))

(fn ->str [x]
  (tostring x))

(lambda command! [name expr ?desc]
  "Define a user command using the lua API.
  See the help for nvim_add_user_command for more information."
  (assert-compile (or (str? name) (sym? name)) "expected string or symbol for name" name)
  (assert-compile (or (str? expr) (fn? expr) (sym? expr)) "expected string or function or symbol for expr" expr)
  (assert-compile (or (nil? ?desc) (str? ?desc)) "expected string or nil for description" ?desc)
  (let [name (->str name)
        desc (if (and (not ?desc) (or (fn? expr) (sym? expr))) (view expr)
               ?desc)]
    `(vim.api.nvim_add_user_command ,name ,expr {:desc ,desc})))

{: command!}
