(module core.plugin.hexokinase
  {require-macros [core.macros]})

(let! Hexokinase_highlighters [:virtual])
(let! Hexokinase_optInPatterns [:full_hex
                                :triple_hex
                                :rgb
                                :rgba
                                :hsl
                                :hsla])
