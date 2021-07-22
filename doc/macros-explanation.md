# Explanation about the macros

The macros were inspired by [zest.nvim](https://github.com/tsbohc/zest.nvim).
If you want macros that are not as opinionated as mine and plug-and-play you
can uso those.

## `gensym-fn!`

This is not really a macro, but a helper function to help generate unique
symbol names for each anonymous function that needs to be used in a map,
auto-command, etc.

### Use

```clojure
> (gensym-fn!)
"__core_symfn_1"
```

## `get?`

This macro lets you get the value of a vim option.

### Use

```clojure
> (get? spell)
true
```

### Result

```clojure
(let [(ok?_0_ value_0_) (pcall (hashfn (: (. vim.opt "spell") "get")))]
  (if ok?_0_ value_0_ nil))
```

## `get-local?`

This macro lets you get the value of a vim local option.

### Use

```clojure
> (get? spell)
true
```

### Result

```clojure
(let [(ok?_0_ value_0_) (pcall (hashfn (: (. vim.opt_local "spell") "get")))]
  (if ok?_0_ value_0_ nil))
```

## `set!`

This macro lets you set a vim option a if you were using vimscript.

```clojure
> (set! spell)
(tset vim.opt "spell" true)

> (set! nospell)
(tset vim.opt "spell" false)

> (set! spell "value")
(tset vim.opt "spell" "value")

> (set! spell?)
(get? "spell")

> (set! spell!)
(tset vim.opt "spell" (not (get? "spell")))

> (set! spell+ "value")
(: (. vim.opt "spell") "append" "value")

> (set! spell- "value")
(: (. vim.opt "spell") "remove" "value")

> (set! spell^ "value")
(: (. vim.opt "spell") "prepend" "value")
```

## `set-local!`

This macro lets you set a vim option a if you were using vimscript.

```clojure
> (set-local! spell)
(tset vim.opt_local "spell" true)

> (set-local! nospell)
(tset vim.opt_local "spell" false)

> (set-local! spell "value")
(tset vim.opt_local "spell" "value")

> (set-local! spell?)
(get-local? "spell")

> (set-local! spell!)
(tset vim.opt_local "spell" (not (get-local? "spell")))

> (set-local! spell+ "value")
(: (. vim.opt_local "spell") "append" "value")

> (set-local! spell- "value")
(: (. vim.opt_local "spell") "remove" "value")

> (set-local! spell^ "value")
(: (. vim.opt_local "spell") "prepend" "value")
```

## `let!`

Lets you set a vim variable as if you were using vimscript... almost.

```clojure
> (let! python3_path "/usr/local/python3")
(tset vim.g "python3_path" "/usr/local/python3")

> (let! g/python3_path "/usr/local/python3")
(tset vim.g "python3_path" "/usr/local/python3")

> (let! b/python3_path "/usr/local/python3")
(tset vim.b "python3_path" "/usr/local/python3")

> (let! w/python3_path "/usr/local/python3")
(tset vim.w "python3_path" "/usr/local/python3")

> (let! t/python3_path "/usr/local/python3")
(tset vim.t "python3_path" "/usr/local/python3")
```

## `augroup!`

Lets you set a vim augroup as if you were using vimscript.

### Use

```clojure
(augroup! group-name ...)
```

### Result

```clojure
(do
  (vim.cmd "augroup group-name\nautocmd!")
  (do
    ...)
  (vim.cmd "augroup END") nil)
```

## `autocmd!`

Lets you set a vim autocmd as if you were using vimscript.

```clojure
> (autocmd! VimEnter * #(print "Hello World"))
(do
  (global __core_symfn_1 (hashfn (print "Hello World")))
  (vim.cmd "autocmd VimEnter * call v:lua.__core_symfn_1()"))

> (autocmd! [Event1 Event2] [*.pdf *.csv] "echom \"Hello World\"")
(vim.cmd "autocmd Event1,Event2 *.pdf,*.csv echom \"Hello World\"")
```

## `map!`

This macro lets you create a mapping as if you were using vimscript.

```clojure
> (map! [nvo] "x" "<C-w>v" :noremap)
(do
  (vim.api.nvim_set_keymap "n" "x" "<C-w>v" {:noremap true})
  (vim.api.nvim_set_keymap "v" "x" "<C-w>v" {:noremap true})
  (vim.api.nvim_set_keymap "o" "x" "<C-w>v" {:noremap true}))
```

## `noremap!`

The same as `map!` but with `noremap` option by default.

## `t`

This macro lets you replace a string with termcodes as needed.

### Use

```clojure
(t "<esc>")
```

### Result

```clojure
(vim.api.nvim_replace_termcodes "<esc>" true true true)
```
