(import-macros {: set!} :themis.opt)

(local utf8 (: (require :conf.deps.utf8) :init))

;;; =========
;;; Utilities
;;; =========

(lambda pad-right [any width]
  "Adds padding to the right of something. That something will be converted
  into an string using the `%s` formatting option."
  (utf8.format (.. "%-" width "s") any))

(lambda pad-left [any width]
  "Adds padding to the left of something. That something will be converted into
  an string using the `%s` formatting option."
  (utf8.format (.. "%" width "s") any))

(lambda trim [str width]
  "Trims an string no an specified width."
  (utf8.sub str 1 width))

(lambda fill [width]
  "Creates an string with an specified width using spaces."
  (utf8.rep " " width))

(lambda get-signs [bufnr ?lnum ?opts]
  "Obtain a list of signs.
  @return {:name   string
           :text   string
           :texthl string}[]"
  (local lnum (if (= :table (type ?lnum)) nil ?lnum))
  (local opts (or ?opts
                  (when (= :table (type ?lnum)) ?lnum)
                  {}))
  (let [placed-signs (vim.fn.sign_getplaced bufnr {:group "*" : lnum})
        placed-signs (. placed-signs 1 :signs)
        placed-signs (if (not= 0 (length placed-signs)) placed-signs [])
        defined-signs (icollect [_ sign (ipairs placed-signs)]
                        (vim.fn.sign_getdefined sign.name))
        signs (icollect [_ [sign] (ipairs defined-signs)] sign)
        signs (if opts.filter-name-by
                (icollect [_ sign (ipairs signs)]
                  (when (sign.name:find opts.filter-name-by) sign))
                signs)]
    signs))

;;; =================
;;; Column components
;;; =================

(lambda linenumber-col [?opts]
  "Line number component for 'statuscolumn'.
  Uses 'numberwidth' for the string total length.
  Respects when 'number' and 'relativenumber' are disabled."
  (local opts (or ?opts {}))
  (set opts.before (or opts.before ""))
  (set opts.after (or opts.after ""))

  (local width (set! numberwidth?))
  (local number? (set! number?))
  (local relativenumber? (set! relativenumber?))
  (local wrapped? (= vim.v.virtnum 1))
  ; If both 'number' and 'relativenumber' are disabled
  (if (and (not number?) (not relativenumber?))
    nil ; Do not display anything
    (..
      opts.before
      (-> (if
            ; If inside wrapped line
            wrapped? (fill width)
            ; If only 'number' is disabled
            (not number?) vim.v.relnum
            ; If only 'relativenumber' is disabled
            (not relativenumber?) vim.v.lnum
            ; When both are enabled we make current line's 'relativenumber' more
            ; prominent
            (= vim.v.relnum 0) (pad-right vim.v.lnum width)
            ;; If not, use the 'relativenumber'
            vim.v.relnum)
         (pad-left width)
         (trim width))
      opts.after)))

(lambda gitsigns-col [bufnr lnum ?opts]
  "Git decoration component for 'statuscolumn'."
  (local opts (or ?opts {}))
  (set opts.before (or opts.before ""))
  (set opts.after (or opts.after ""))

  (local WIDTH 1)
  (if (= 0 (length (get-signs bufnr {:filter-name-by "GitSign"})))
    nil
    (..
      opts.before
      (let [signs (get-signs bufnr lnum {:filter-name-by "GitSign"})
            sign (. signs 1)]
        (if (= nil sign) (fill WIDTH)
          (.. "%#" sign.texthl "#"
              (-> sign.text
                  (pad-left WIDTH)
                  (trim WIDTH))
              "%*")))
      opts.after)))

(lambda diagnostics-col [bufnr lnum ?opts]
  "Diagnostics component for 'statuscolumn'."
  (local opts (or ?opts {}))
  (set opts.before (or opts.before ""))
  (set opts.after (or opts.after ""))

  (local WIDTH 2)
  (if (= 0 (length (vim.diagnostic.get bufnr)))
    nil ; Do not display anything
    (..
      opts.before
      (let [signs (get-signs bufnr lnum {:filter-name-by "DiagnosticSign"})
            sign (. signs 1)]
        (if (= nil sign) (fill WIDTH)
          (.. "%#" sign.texthl "#"
              (-> sign.text
                  (pad-left WIDTH)
                  (trim WIDTH))
              "%*")))
      opts.after)))

(lambda _G.statuscolumn []
  "An 'statuscolumn'."
  (local bufnr (vim.fn.bufnr))
  (local lnum vim.v.lnum)
  (let [diagnostics (diagnostics-col bufnr lnum {:before " "})
        linenumber (linenumber-col {:before " " :after " "})
        gitsigns (gitsigns-col bufnr lnum {:after " "})]
    (.. "%="
        (or diagnostics "")
        (if (and
              (not= nil diagnostics)
              (or (= nil linenumber) (= nil gitsigns))) " "
          "")
        (or linenumber "")
        (or gitsigns ""))))

(set! signcolumn "no")
(set! foldcolumn "0")
(set! statuscolumn "%{%v:lua.statuscolumn()%}")
