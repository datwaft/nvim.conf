(import-macros {: map!} :crux.lib.macro.vim)

(map! [n] "<localleader>ee" "<Plug>SnipRun")
(map! [n] "<localleader>E" "<Plug>SnipRunOperator")
(map! [v] "<localleader>E" "<Plug>SnipRun")
