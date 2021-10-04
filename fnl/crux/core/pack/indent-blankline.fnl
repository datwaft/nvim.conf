(local {: setup} (require :indent_blankline))

(setup {:char "│"
        :use_treesitter true
        :filetype_exclude [:terminal :help :packer :NvimTree :fennel :clojure
                           :lisp :markdown]
        :buftype_exclude [:terminal :nofile]
        :show_current_context true
        :context_patterns [:class :return :function :method :^if :^while
                           :jsx_element :^for :^object :^table :block
                           :arguments :if_statement :else_clause :jsx_element
                           :jsx_self_closing_element :try_statement
                           :catch_clause :import_statement]})
