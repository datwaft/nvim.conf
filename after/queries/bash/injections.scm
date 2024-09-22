;; extends

;; zsh-defer -c '<bash code>'
(command
  name: (command_name) @_zsh_defer
  (#eq? @_zsh_defer "zsh-defer")
  argument: (word) @__c
  (#eq? @__c "-c")
  .
  argument: (raw_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "bash"))
