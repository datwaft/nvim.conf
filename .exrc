augroup local_options
  autocmd!
  autocmd BufRead lazy-lock.json let b:spell_disabled = 1 | setlocal readonly nospell norelativenumber
augroup END
