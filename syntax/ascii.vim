" Vim syntax file
" Language:		ASCII
" Maintainer:		Tyler Warren <tyler@warrens.one>
" Last Change:		2026 Jul 21

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

" Ascii Headers
syn match headerDivStart "^[-]\+\[" contained
syn match headerDivEnd "\][-]\+$" contained
syn match headerName "\(\[\s*\)\@<=[a-z0-9\.\- ]\+\(\s*\]\)\@=" contained
syn match headerSpan "^[-]\+\[\s*[a-z0-9\.\- ]\+\s*\][-]\+$" contains=headerDivStart,headerName,headerDivEnd

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
"hi def link asmSection		Special
"hi def link asmLabel		Label
"hi def link asmComment		Comment
"hi def link asmTodo		Todo
"hi def link asmDirective	Statement
"
"hi def link asmInclude		Include
"hi def link asmCond		PreCondit
"hi def link asmMacro		Macro
"
"if exists('g:asm_legacy_syntax_groups')
"  hi def link hexNumber		Number
"  hi def link decNumber		Number
"  hi def link octNumber		Number
"  hi def link binNumber		Number
"  hi def link asmHexadecimal	hexNumber
"  hi def link asmDecimal	decNumber
"  hi def link asmOctal		octNumber
"  hi def link asmBinary		binNumber
"else
"  hi def link asmHexadecimal	Number
"  hi def link asmDecimal	Number
"  hi def link asmOctal		Number
"  hi def link asmBinary		Number
"endif
"hi def link asmFloat		Float
"
"hi def link asmString		String
"hi def link asmStringEscape	Special
"hi def link asmCharacter	Character
"hi def link asmCharacterEscape	Special

hi def link headerDivStart	Comment
hi def link headerDivEnd	Comment
hi def link headerName		Label

let b:current_syntax = "ascii"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
