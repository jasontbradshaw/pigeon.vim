" Pigeon Vim syntax
" Language: https://github.com/mna/pigeon
" Latest Revision: 2017-08-31
" Maintainer: Jason T. Bradshaw

if exists("b:current_syntax")
  finish
endif

" Code blocks, both outside and inside rules.
syn include @go syntax/go.vim
syn region pigeonCodeBlock matchgroup=pigeonDelimiter start=/^{/ end=/}$/ contains=@go
syn region pigeonRuleCodeBlock matchgroup=pigeonDelimiter start='{' end='}' skipwhite contained contains=@go

" Comments
syn keyword pigeonTodo TODO FIXME XXX NOTE contained
syn match   pigeonComment /\/\/.*$/ contains=pigeonTodo
syn region  pigeonComment start="/\*" end="\*/" contains=pigeonTodo

" Rules
syn match pigeonRuleId /^\w\+/ skipwhite nextgroup=pigeonRuleName,pigeonRuleOp

syn region pigeonRuleName start=/"/ end=/"/ skipwhite skipnl nextgroup=pigeonRuleOp
syn region pigeonRuleName start=/'/ end=/'/ skipwhite skipnl nextgroup=pigeonRuleOp
syn region pigeonRuleName start=/`/ end=/`/ skipwhite skipnl nextgroup=pigeonRuleOp

syn match pigeonRuleOp "<-" skipwhite contained nextgroup=pigeonRule
syn match pigeonRuleOp "="  skipwhite contained nextgroup=pigeonRule
syn match pigeonRuleOp "←"  skipwhite contained nextgroup=pigeonRule
syn match pigeonRuleOp "⟵"  skipwhite contained nextgroup=pigeonRule

" Rule labels
syn match pigeonLabel      /\w\+:/ contains=pigeonLabelDelim nextgroup=pigeonRule
syn match pigeonLabelDelim /:/ contained display

" A rule is basically anything, but contains a bunch of other things.
syn match pigeonRule /.\+/ contained skipwhite contains=pigeonRuleCodeBlock,pigeonLabel,pigeonDelimiter,pigeonGrouping,pigeonSpecial,pigeonRange,pigeonString,pigeonChoice,pigeonRepeater

" Rule 'innards'
syn match pigeonChoice   /\// contained display
syn match pigeonRepeater /[+\*?]/ contained display
syn match pigeonSpecial  /[!.&^]/ contained display

syn match pigeonRangeValue /.-[^\\]/ contained display
syn match pigeonRangeValue /.-\\u[a-fA-F0-9]\{4,6}/ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\u[a-fA-F0-9]\{4,6}-./ contained display contains=pigeonUnicode
syn match pigeonRangeValue /\\u[a-fA-F0-9]\{4,6}-\\u[a-fA-F0-9]\{4,6}/ contained display contains=pigeonUnicode

syn region pigeonGrouping matchgroup=pigeonDelimiter start=/(/ end=/)/ contained skipwhite keepend contains=pigeonRule display
syn region pigeonRange    matchgroup=pigeonDelimiter start=/\[^/ start=/\[/ end=/\]/ contained skipwhite contains=pigeonRangeValue,pigeonUnicode display
syn region pigeonString   matchgroup=pigeonDelimiter start=/"/ end=/"/ contained display contains=pigeonUnicode
syn region pigeonString   matchgroup=pigeonDelimiter start=/'/ end=/'/ contained display contains=pigeonUnicode
syn region pigeonString   matchgroup=pigeonDelimiter start=/`/ end=/`/ contained display contains=pigeonUnicode

hi link pigeonChoice     Conditional
hi link pigeonComment    Comment
hi link pigeonDelimiter  Delimiter
hi link pigeonLabel      Define
hi link pigeonLabelDelim Delimiter
hi link pigeonRangeValue Constant
hi link pigeonRepeater   Function
hi link pigeonRuleId     Identifier
hi link pigeonRuleName   String
hi link pigeonRuleOp     Conditional
hi link pigeonSpecial    Special
hi link pigeonString     String
hi link pigeonTodo       Todo
hi link pigeonUnicode    Constant

let b:current_syntax = "pigeon"
