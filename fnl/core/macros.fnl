{;; Create an augroup for your autocmds.
 ; (augroup my-group
 ;   (nvim.ex.autocmd ...))
 :augroup
 (fn [name ...]
   `(do
      (vim.cmd (.. "augroup " ,(tostring name) "\nautocmd!"))
      ,...
      (vim.cmd "augroup END")
      nil))}
