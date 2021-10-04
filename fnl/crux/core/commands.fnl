(import-macros {: command!} :crux.lib.macro.vim)

(command! Scratch "new | setlocal bt=nofile bh=wipe nobl noswapfile nu ft=fennel")
(command! SetScratch "edit [Scratch] | setlocal bt=nofile bh=wipe nobl noswapfile nu ft=fennel")
