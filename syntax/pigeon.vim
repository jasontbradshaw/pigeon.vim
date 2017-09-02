" Pigeon Vim syntax
" Language: https://github.com/mna/pigeon
" Latest Revision: 2017-08-31
" Maintainer: Jason T. Bradshaw

if exists("b:current_syntax")
  finish
endif

" Code blocks, both outside and inside rules.
syn include @go syntax/go.vim
syn region pigeonCodeBlock     matchgroup=pigeonDelimiter start=/^{/ end=/}$/ contains=@go
syn region pigeonRuleCodeBlock matchgroup=pigeonDelimiter start='{' end='}' skipwhite contained contains=@go

" Comments
syn keyword pigeonTodo TODO FIXME XXX NOTE contained
syn match   pigeonComment /\/\/.*$/ contains=pigeonTodo
syn region  pigeonComment start="/\*" end="\*/" contains=pigeonTodo

" Rules
syn match pigeonRuleId /^\w\+/ skipwhite skipnl nextgroup=pigeonRuleName,pigeonRuleOp

syn region pigeonRuleName start=/"/ end=/"/ skipwhite skipnl nextgroup=pigeonRuleOp
syn region pigeonRuleName start=/'/ end=/'/ skipwhite skipnl nextgroup=pigeonRuleOp
syn region pigeonRuleName start=/`/ end=/`/ skipwhite skipnl nextgroup=pigeonRuleOp

syn match pigeonRuleOp "<-" skipwhite skipnl contained nextgroup=pigeonRule
syn match pigeonRuleOp "="  skipwhite skipnl contained nextgroup=pigeonRule
syn match pigeonRuleOp "←"  skipwhite skipnl contained nextgroup=pigeonRule
syn match pigeonRuleOp "⟵"  skipwhite skipnl contained nextgroup=pigeonRule

" Rule labels
syn match pigeonLabel      /\w\+:/ contains=pigeonLabelDelim nextgroup=pigeonRule
syn match pigeonLabelDelim /:/ contained display

" A rule is basically anything, but contains a bunch of other things.
syn region pigeonRule start='' end=/^\w/me=s-1 end=/^\s*$/me=s-1 contained contains=pigeonRuleCodeBlock,pigeonComment,pigeonLabel,pigeonDelimiter,pigeonGrouping,pigeonSpecial,pigeonRange,pigeonChar,pigeonString,pigeonChoice,pigeonRepeater

" Rule 'innards'
syn match pigeonChoice   /\/[^/*]/ contained display
syn match pigeonChoice   /\/$/ contained display
syn match pigeonRepeater /[+\*?]/ contained display
syn match pigeonSpecial  /[!.&^]/ contained display
syn match pigeonUnicode  /\\u[a-fA-F0-9]\{4}/ contained display
syn match pigeonUnicode  /\\U[a-fA-F0-9]\{8}/ contained display

syn match pigeonRangeValue /.-[^\\\]]/ contained display
syn match pigeonRangeValue /.-\\u[a-fA-F0-9]\{4}/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\u[a-fA-F0-9]\{4}-./ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\u[a-fA-F0-9]\{4}-\\u[a-fA-F0-9]\{4}/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /.-\\U[a-fA-F0-9]\{8}/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\U[a-fA-F0-9]\{8}-./ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\U[a-fA-F0-9]\{8}-\\U[a-fA-F0-9]\{8}/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\p[LMNCPZS]/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\p{\w\+}/ contained display contains=pigeonUnicode

syn match pigeonCharDelim /'/ contained display
syn match pigeonChar      /'\\u[a-fA-F0-9]\{4}'/ contained display contains=pigeonUnicode,pigeonCharDelim nextgroup=pigeonCaseInsensitive
syn match pigeonChar      /'\\U[a-fA-F0-9]\{8}'/ contained display contains=pigeonUnicode,pigeonCharDelim nextgroup=pigeonCaseInsensitive
syn match pigeonChar      /'\\.'/ contained display contains=pigeonUnicode,pigeonCharDelim nextgroup=pigeonCaseInsensitive
syn match pigeonChar      /'[^\\]'/ contained display contains=pigeonUnicode,pigeonCharDelim nextgroup=pigeonCaseInsensitive

syn region pigeonGrouping matchgroup=pigeonDelimiter start=/(/ end=/)/ contained skipwhite keepend extend contains=pigeonRule display
syn region pigeonRange    matchgroup=pigeonDelimiter start=/\[^/ start=/\[/ end=/\]/ contained contains=pigeonRangeValue,pigeonUnicode display nextgroup=pigeonCaseInsensitive
syn region pigeonString   matchgroup=pigeonDelimiter start=/"/ end=/"/ contained display contains=pigeonUnicode nextgroup=pigeonCaseInsensitive
syn region pigeonString   matchgroup=pigeonDelimiter start=/`/ end=/`/ contained display contains=pigeonUnicode nextgroup=pigeonCaseInsensitive

syn match pigeonCaseInsensitive 'i' contained display

hi link pigeonCaseInsensitive Special
hi link pigeonChar            String
hi link pigeonCharDelim       Delimiter
hi link pigeonChoice          Conditional
hi link pigeonComment         Comment
hi link pigeonDelimiter       Delimiter
hi link pigeonLabel           Define
hi link pigeonLabelDelim      Delimiter
hi link pigeonRange           String
hi link pigeonRangeValue      Constant
hi link pigeonRepeater        Function
hi link pigeonRuleComment     Comment
hi link pigeonRuleId          Identifier
hi link pigeonRuleName        String
hi link pigeonRuleOp          Conditional
hi link pigeonSpecial         Special
hi link pigeonString          String
hi link pigeonTodo            Todo
hi link pigeonUnicode         Constant

let b:current_syntax = "pigeon"
