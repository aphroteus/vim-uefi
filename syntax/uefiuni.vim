" Vim syntax file
" Language:	UEFI UNI
" Maintainer:	Paul Huang
" Last Change:	2017 Feb 14

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"unlet b:current_syntax

syn case match
syn match	uniKeyword	"#\(font\|fontdef\|string\|langdef\|language\)"
syn region	uniString	start=+L\="+ skip=+\\\\\|\\"+ end=+"+
syn region	uniCommentL	start="//" skip="\\$" end="$" keepend


" Comment
hi def link uniCommentL		Comment
" Constant - String Character Number Boolean Float
hi def link uniString		String
" Identifier - Function
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link uniKeyword		Statement
" PreProc - Include Define Macro PreCondit
" Type - StorageClass Structure Typedef
" Special - SpecialChar Tag Delimiter SpecialComment Debug
" Underlined
" Ignore
" Error
" Todo




let b:current_syntax = "uefiuni"

" vim:ts=8:foldmethod=marker
