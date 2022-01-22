(local {: warn!} (require :conf.lib.io))
(local {: format} string)

(fn empty? [xs]
  (= 0 (length xs)))

(lambda assert-dependencies! [module-name dependencies]
  "Prints a warning for each dependency that cannot be required.
  Returns true if every dependency is available and false if not."
  (let [not-available (icollect [_ dep (ipairs dependencies)]
                                (when (not (pcall require dep))
                                  dep))]
    (if (empty? not-available) true
      (do
        (each [_ dep (ipairs not-available)]
          (warn! (format "Could not load %s as %s is not available."
                         module-name dep)))
        false))))

{: assert-dependencies!}
