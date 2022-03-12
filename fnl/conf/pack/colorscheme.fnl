(import-macros {: let!} :conf.macro.var)
(import-macros {: highlight!} :conf.macro.highlight)
(import-macros {: autocmd!
                : augroup!} :conf.macro.event)

(let! enfocado_style "nature")

(autocmd! VimEnter * [:nested] "colorscheme enfocado")

(augroup! colorscheme-customization
          (autocmd! ColorScheme enfocado (highlight! CarbonDir [:bold] {:fg "#00aaff"}))
          (autocmd! ColorScheme enfocado (highlight! CarbonFile [:bold] {:fg "#f8f8f8"}))
          (autocmd! ColorScheme enfocado (highlight! CarbonExe [:bold] {:fg "#22cc22"}))
          (autocmd! ColorScheme enfocado (highlight! CarbonSymlink [:bold] {:fg "#d77ee0"}))
          (autocmd! ColorScheme enfocado (highlight! CarbonBrokenSymlink [:bold] {:fg "#ea871e"}))
          (autocmd! ColorScheme enfocado (highlight! CarbonIndicator [:bold] {:fg "Gray"})))
