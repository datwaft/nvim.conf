(import-macros {: pack} :themis.pack.lazy)

[;; PlantUML
 (pack "weirongxu/plantuml-previewer.vim" {:ft "plantuml"
                                           :dependencies ["tyru/open-browser.vim"]})
 ;; Markdown
 (pack "iamcco/markdown-preview.nvim" {:build "cd app & npm install"
                                       :ft "markdown"})]
