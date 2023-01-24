(import-macros {: set!} :themis.opt)

(fn _G.linenumber []
  "Line number component for 'statuscolumn'.
  Uses 'numberwidth' for the string total length.
  Respects when 'number' and 'relativenumber' are disabled."

  (fn use-numberwidth [s]
    "Make input the same length of 'numberwidth'.
    Only does that if the input is not nil."
    (if (= nil s) ""
      (string.format (.. "%" (set! numberwidth?) :s) s)))

  (-> (let [lnum? (set! number?)
            relnum? (set! relativenumber?)]
        (if
          ; If inside wrapped line
          (= vim.v.virtnum 1) nil
          ; If both 'number' and 'relativenumber' are disabled
          (and (not lnum?) (not relnum?)) nil
          ; If only 'number' is disabled
          (not lnum?) vim.v.relnum
          ; If only 'relativenumber' is disabled
          (not relnum?) vim.v.lnum
          ; When both are enabled we make current line's 'relativenumber' more
          ; prominent
          (= vim.v.relnum 0) (string.format "%-3d" vim.v.lnum)
          vim.v.relnum))
      (use-numberwidth)))

(fn sign-name-from-group [bufnr lnum group]
  "Obtain the first sign name for the buffer and line number specified.
  Uses the group name to filter the signs."
  (let [group-signs (vim.fn.sign_getplaced bufnr {: group : lnum})]
    (?. group-signs 1 :signs 1 :name)))

(fn _G.gitsign []
  "Git decoration component for 'statuscolumn'."
  (local name->sign
    {:GitSignsAdd          "│"
     :GitSignsChange       "│"
     :GitSignsChangedelete "_"
     :GitSignsDelete       "‾"
     :GitSignsTopdelete    "~"
     :GitSignsUntracked    "┆"})
  (let [name (sign-name-from-group (vim.fn.bufnr) vim.v.lnum
                                   :gitsigns_vimfn_signs_)]
    (if (not= name nil)
      (.. "%#" name "#" (. name->sign name) "%*")
      " ")))

(fn _G.diagnostics []
  (local name->sign
    {:DiagnosticSignError conf.icons.error
     :DiagnosticSignWarn  conf.icons.warn
     :DiagnosticSignInfo  conf.icons.info
     :DiagnosticSignHint  conf.icons.hint
     :DiagnosticSignOk    conf.icons.ok})
  (let [name (sign-name-from-group (vim.fn.bufnr) vim.v.lnum "*")]
    (if (and (not= nil name) (vim.startswith name "DiagnosticSign"))
      (.. "%#" name "#" (. name->sign name) "%*")
      "  ")))

(fn _G.statuscolumn []
  (.. "%="
      "%{%v:lua.diagnostics()%}"
      "%{v:lua.linenumber()}"    " "
      "%{%v:lua.gitsign()%}"     " "))

(set! statuscolumn "%!v:lua.statuscolumn()")
