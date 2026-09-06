" Vim syntax file
" Language:    UEFI FDF
" Maintainer:  Paul Huang
" Last Change: 2026 Sep 03

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match
syn keyword fdfSection                  Defines FD FV Capsule VTF Rule OptionRom
" {{{ Table 2. Well-known Macro Statements
syn keyword fdfMacro                    PACKAGES_PATH EDK_TOOLS_BIN
syn match   fdfMacroMatch               "\$(\(WORKSPACE\|EDK_SOURCE\|EFI_SOURCE\|EDK_TOOLS_PATH\|ECP_SOURCE\|OUTPUT_DIRECTORY\|BUILD_NUMBER\|NAMED_GUID\|MODULE_NAME\|INF_VERSION\|INF_OUTPUT\|TARGET\|TOOL_CHAIN_TAG\|ARCH\))"
" }}}
syn keyword fdfKeyword                  TOKEN DEFINE SET INF FILE
syn keyword fdfFVFileType               RAW FREEFORM SEC PEI_CORE DXE_CORE PEIM DRIVER COMBO_PEIM_DRIVER SMM_CORE DXE_SMM_DRIVER APPLICATION FV_IMAGE DISPOSABLE

syn keyword fdfBoolean                  TRUE true True 0x1 0x01 1 FALSE false False 0x0 0x00 0
" Table 5. Operator Precedence and Supported Operands {{{
syn keyword fdfOperator                 or OR and AND xor XOR EQ NE IN LE GE LT GT not NOT
syn match   fdfOperator                 "||\|&&\||\|==\|!=\|<=\|>=\|<\|>\|+\|-\|!"
" }}}
syn keyword fdfType                     BOOLEAN UINT8 UINT16 UINT32 UINT64 UINT8z UINT16z UINT32z UINT64z VOID
syn match   fdfFieldSeparator           "|"
syn region  fdfComment                  start="#" end="$" contains=@Spell
syn keyword fdfKeyword                  !include
syn match   fdfConditional              "!\(ifdef\|ifndef\|if\|elseif\|else\|endif\)"
syn region  fdfVariable                 start="\$(" skip="\\)\|\\\\" end=")"

syn match   cGUID                       "{\s*0x\x\{8},\s*0x\x\{4},\s*0x\x\{4},\s*{\s*\(0x\x\{2},\s*\)\{7}0x\x\{2}\s*}\s*}"
syn match   cNullGuid                   "{\s*\(0x0,\s*\)\{3}{\s*\(0x0,\s*\)\{7}0x0\s*}\s*}"
syn match   stdGUID                     "\x\{8}\-\x\{4}-\x\{4}\-\x\{4}\-\x\{12}"
syn match   fdfNumber                   display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"


" Highlight Default Link {{{
" Comment
hi def link fdfComment                  Comment
" Constant
" String
" Character
" Number
hi def link fdfNumber                   Number
" Boolean
hi def link fdfBoolean                  Boolean
" Float
" Identifier
hi def link fdfVariable                 Identifier
hi def link cGUID                       Identifier
hi def link cNullGuid                   Identifier
hi def link stdGUID                     Identifier
" Function
" Statement
" Conditional
hi def link fdfConditional              Conditional
" Repeat
" Label
" Operator
hi def link fdfOperator                 Operator
" Keyword
hi def link fdfKeyword                  Keyword
hi def link fdfSection                  Keyword
" Exception
" PreProc
" Include
" Define
" Macro
hi def link fdfMacroMatch               Macro
hi def link fdfMacro                    Macro
" PreCondit
" Type
hi def link fdfType                     Type
hi def link fdfFVFileType               Type
" StorageClass
" Structure
" Typedef
" Special
" SpecialChar
" Tag
" Delimiter
hi def link fdfFieldSeparator           Delimiter
" SpecialComment
" Debug
" Underlined
" Ignore
" Error
" Todo
" }}}

syn sync minlines=50

let b:current_syntax = "uefifdf"

" vim:ts=8:foldmethod=marker
