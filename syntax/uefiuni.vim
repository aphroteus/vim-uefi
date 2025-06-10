" Vim syntax file
" Language:    UEFI UNI
" Maintainer:  Paul Huang
" Last Change: 2025 Jun 10

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match
syn match   uniKeyword                  "#\(font\|fontdef\|string\|langdef\|language\)"
syn region  uniString                   start=+L\="+ skip=+\\\\\|\\"+ end=+"+
syn region  uniCommentL                 start="//" skip="\\$" end="$" keepend


" Highlight Default Link {{{
" Comment
hi def link uniCommentL                 Comment
" Constant
" String
hi def link uniString                   String
" Character
" Number
" Boolean
" Float
" Identifier
" Function
" Statement
hi def link uniKeyword                  Statement
" Conditional
" Repeat
" Label
" Operator
" Keyword
" Exception
" PreProc
" Include
" Define
" Macro
" PreCondit
" Type
" StorageClass
" Structure
" Typedef
" Special
" SpecialChar
" Tag
" Delimiter
" SpecialComment
" Debug
" Underlined
" Ignore
" Error
" Todo
" }}}


let b:current_syntax = "uefiuni"

" vim:ts=8:foldmethod=marker
