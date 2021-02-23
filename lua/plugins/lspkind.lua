-- =====================
-- LSPKIND CONFIGURATION
-- =====================
-- Created by datwaft <github.com/datwaft>

return function()
  require'lspkind'.init {
    with_text = true,
    symbol_map = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '汹',
      Variable = '衮',
      Class = '㕡',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '撴',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '凇',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '沜',
      Struct = ''
    },
  }
end
