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

(fn get-signs [bufnr lnum]
  "Obtain a list of signs.
  @return {:name   string
           :text   string
           :texthl string}[]"
  (let [placed-signs (vim.fn.sign_getplaced bufnr {:group "*" : lnum})
        placed-signs (. placed-signs 1 :signs)
        defined-signs (icollect [_ sign (ipairs placed-signs)]
                        (vim.fn.sign_getdefined sign.name))]
       (icollect [_ [sign] (ipairs defined-signs)]
         sign)))

(fn get-signs-for [bufnr lnum partial-name]
  "Obtain a list of signs.
  Filters by `partial-name`.
  @return {:name   string
           :text   string
           :texthl string}[]"
  (icollect [_ sign (ipairs (get-signs bufnr lnum))]
    (when (sign.name:find partial-name) sign)))

(fn _G.gitsign []
  "Git decoration component for 'statuscolumn'."
  (let [signs (get-signs-for (vim.fn.bufnr) vim.v.lnum "GitSign")
        sign (. signs 1)]
    (if (= nil sign) "  "
      (.. "%#" sign.texthl "#" sign.text "%*"))))

(fn _G.diagnostics []
  "Diagnostics component for 'statuscolumn'."
  (let [signs (get-signs-for (vim.fn.bufnr) vim.v.lnum "DiagnosticSign")
        sign (. signs 1)]
    (if (= nil sign) "  "
      (.. "%#" sign.texthl "#" sign.text "%*"))))

(fn _G.statuscolumn []
  "An 'statuscolumn'."
  (.. "%="
      "%{%v:lua.diagnostics()%}"
      "%{v:lua.linenumber()} "
      "%{%v:lua.gitsign()%}"))

(set! statuscolumn "%!v:lua.statuscolumn()")
