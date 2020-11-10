" Vim Syntax File
"
" Language: Prolog
" Maintainers: datwaft <github.com/datwaft>
" Created: 2020-10-19
" Changed: 2020-10-21
" Remark: This prolog file differentiates between functors and normal atoms.

" => Initialization
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match
" => Language definition
  " -> Keywords
    syntax keyword prologKeywordTrue true
    syntax keyword prologKeywordFalse false fail
    syntax cluster prologKeywords contains=prologKeywordFalse,prologKeywordTrue
  " -> Operator
    syntax match prologOperator ';'
    syntax match prologOperator '|'
    syntax match prologOperator ','
    syntax match prologOperator '->'
    syntax match prologOperator '*->'
    syntax match prologOperator ':='
    syntax match prologOperator '\\+'
    syntax match prologOperator '<'
    syntax match prologOperator '='
    syntax match prologOperator '=\.\.'
    syntax match prologOperator '=@='
    syntax match prologOperator '\\=@='
    syntax match prologOperator '=:='
    syntax match prologOperator '=<'
    syntax match prologOperator '=='
    syntax match prologOperator '=\\='
    syntax match prologOperator '>'
    syntax match prologOperator '>='
    syntax match prologOperator '@<'
    syntax match prologOperator '@=<'
    syntax match prologOperator '@>'
    syntax match prologOperator '@>='
    syntax match prologOperator '\\='
    syntax match prologOperator '\\=='
    syntax keyword prologOperator is
    syntax match prologOperator '>:<'
    syntax match prologOperator ':<'
    syntax match prologOperator '#='
    syntax match prologOperator ':'
    syntax match prologOperator '+'
    syntax match prologOperator '-'
    syntax match prologOperator '\/\\'
    syntax match prologOperator '\\\/'
    syntax keyword prologOperator xor
    syntax match prologOperator '?'
    syntax match prologOperator '\*'
    syntax match prologOperator '\/'
    syntax match prologOperator '\/\/'
    syntax match prologOperator '<<'
    syntax match prologOperator '>>'
    syntax keyword prologOperator div rdiv mod rem
    syntax match prologOperator '\*\*'
    syntax match prologOperator '\^'
    syntax match prologOperator '\\'
    syntax match prologOperator '\.'
    syntax match prologOperator '$'
    syntax match prologOperator '[()]'
    syntax match prologOperator '[{\}]'
    syntax match prologSpecialOperator '!'
    syntax cluster prologOperators contains=prologOperator,prologSpecialOperator
  " -> Atom
    syntax match prologAtom '\[\]'
    syntax match prologAtom '[a-z]\w*'
    syntax region prologAtom start="'" end="'" oneline extend
  " -> Numbers
    syntax match prologNumber '\d\+'
    syntax match prologNumber '[-+]\d\+'
    syntax match prologFloat '\d\+\.\d\+'
    syntax match prologFloat '[-+]\d\+\.\d\+'
    syntax match prologFloat '\.\d\+'
    syntax cluster prologNumbers contains=prologNumber,prologFloat
  " -> List
    syntax region prologList matchgroup=prologListDelimiter start='\[' end='\]' contains=prologListDivisor,@prologAll
    syntax match prologListDivisor '[,|]' contained
  " -> Fuctor
    " Functor
      syntax match prologFunctor '[a-z]\w*\((\)\@=' nextgroup=prologParameters
      syntax match prologFunctor "'.\{-}'\((\)\@=" nextgroup=prologParameters
    " Parameters
      syntax region prologParameters matchgroup=prologParameterDelimiter start='(' end=')' contained contains=prologParameterDivisor,@prologAll extend
      syntax match prologParameterDivisor ',' contained containedin=prologParameters
  " -> Variables
    " Varable
      syntax match prologVariable '[A-Z][A-Za-z0-9_]*'
    " Anonymous Variable
      syntax match prologAnonymousVariable '_[A-Za-z0-9_]*'
    syntax cluster prologVariables contains=prologVariable,prologAnonymousVariable
  " -> String
    syntax region prologString start='"' skip='\\"' end='"' extend
  " -> Body
    " Normal Body
      syntax region prologBody matchgroup=prologBodyDelimiter start=':-' end='\.' contains=@prologAll
      syntax region prologBody matchgroup=prologBodyDelimiter start='?-' end='\.' contains=@prologAll
    " DCG Body
      syntax region prologDCGBody matchgroup=prologDCGBodyDelimiter start='-->' end='\.' contains=@prologAll,prologDCGBodyDivisor
      syntax match prologDCGBodyDivisor '[{\}]' contained containedin=prologDCGBody
  " -> Comment
    syntax region prologComment start="%" end="$"
    syntax region prologCComment fold start=/\/\*/ end=/\*\//
    syntax cluster prologComments contains=prologComment,prologCComment
  " -> All
    syntax cluster prologAll contains=@prologKeywords,@prologOperators,prologAtom,@prologNumbers,prologList,prologFunctor,@prologVariables,prologString,@prologComments
" => Color definition
  " -> Keywords
    highlight prologKeywordTrue ctermfg=green cterm=italic guifg=#C3E88D gui=italic
    highlight prologKeywordFalse ctermfg=red cterm=italic guifg=#FF5370 gui=italic
  " -> Operators
    highlight prologOperator ctermfg=cyan guifg=#89DDFF
    highlight prologSpecialOperator ctermfg=red cterm=bold guifg=#FF5370 gui=bold
  " -> Atoms
    highlight link prologAtom Define
  " -> Numbers
    highlight link prologNumber Number
    highlight link prologFloat Float
  " -> Lists
    highlight prologListDivisor ctermfg=blue cterm=bold guifg=#82AAFF gui=bold
    highlight prologListDelimiter ctermfg=blue cterm=bold guifg=#82AAFF gui=bold
  " -> Functors
    highlight link prologFunctor Function
  " -> Varables
    highlight prologVariable ctermfg=yellow cterm=bold guifg=#FFCB6B gui=bold
  " -> Anonymous Variables
    highlight prologAnonymousVariable ctermfg=yellow cterm=italic guifg=#FFCB6B gui=italic
  " -> Parameters
    highlight prologParameterDivisor ctermfg=red cterm=bold guifg=#FF5370 gui=bold
    highlight prologParameterDelimiter ctermfg=red cterm=bold guifg=#FF5370 gui=bold
  " -> Strings
    highlight link prologString String
  " -> Body
    highlight prologBodyDelimiter ctermfg=cyan cterm=bold guifg=#89DDFF gui=bold
    highlight prologDCGBodyDivisor ctermfg=cyan cterm=bold guifg=#89DDFF gui=bold
    highlight prologDCGBodyDelimiter ctermfg=cyan cterm=bold guifg=#89DDFF gui=bold
  " -> Comments
    highlight link prologComment Comment
    highlight link prologCComment Comment
" => Finalization
let b:current_syntax = "prolog"
