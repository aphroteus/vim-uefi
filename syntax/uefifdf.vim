" Vim syntax file
" Language:	UEFI FDF
" Maintainer:	Paul Huang
" Last Change:	2016 Dec 27

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"unlet b:current_syntax

syn case match
syn keyword	fdfSection	Defines FD FV Capsule VTF Rule OptionRom
" {{{ Table 2. Well-known Macro Statements
syn keyword	fdfMacro	PACKAGES_PATH EDK_TOOLS_BIN
syn match	fdfMacroh	"\$(\(WORKSPACE\|EDK_SOURCE\|EFI_SOURCE\|EDK_TOOLS_PATH\|ECP_SOURCE\|OUTPUT_DIRECTORY\|BUILD_NUMBER\|NAMED_GUID\|MODULE_NAME\|INF_VERSION\|INF_OUTPUT\|TARGET\|TOOL_CHAIN_TAG\|ARCH\))"
" }}}
syn keyword	fdfStatement	TOKEN DEFINE SET INF FILE
syn keyword	fdfFVFileType	RAW FREEFORM SEC PEI_CORE DXE_CORE PEIM DRIVER COMBO_PEIM_DRIVER SMM_CORE DXE_SMM_DRIVER APPLICATION FV_IMAGE DISPOSABLE

syn keyword	dscBoolean	TRUE true True 0x1 0x01 1 FALSE false False 0x0 0x00 0 
" Table 5. Operator Precedence and Supported Operands {{{
syn keyword	fdfOperator	or OR and AND xor XOR EQ NE IN LE GE LT GT not NOT
syn match	fdfOperator	"||\|&&\||\|==\|!=\|<=\|>=\|<\|>\|+\|-\|!"
" }}}
syn keyword	dscType		BOOLEAN UINT8 UINT16 UINT32 UINT64 UINT8z UINT16z UINT32z UINT64z VOID
syn match	dscFieldSeparator	"|" 
syn region	fdfComment		start="#" end="$" contains=@Spell
syn keyword	fdfStatement	!include
syn match	fdfConditional	"!\(ifdef\|ifndef\|if\|elseif\|else\|endif\)"
syn region	dscVariable		start="\$(" skip="\\)\|\\\\" end=")"



syn match	decFileSep	"\/"
syn match	decFile		"\w\(\.\|\w\|\-\)*\.\(\w\|-\)\+"
syn match	decCommaSpace	transparent contained "\,\s+"
syn match	decRegistryFormatGUID "\x\{8}\-\x\{4}-\x\{4}\-\x\{4}\-\x\{12}"
syn region	decCFormatGUID	start="{\s*0\(x\|X\)\x\{8}\,\s\+" end="0\(x\|X\)\x\{2}\s*\}\s*\}" oneline contains=decCommaSpace
syn match	decNumber	display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"


hi x220_Gold1			ctermfg=220 guifg=#ffd700

" Comment
hi def link fdfComment		Comment
" Constant - String Character Number Boolean Float
hi def link decNumber		Number
hi def link dscBoolean		Boolean
" Identifier - Function
hi def link dscVariable		Identifier
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link fdfStatement	Statement
hi def link fdfConditional	Conditional
hi def link fdfOperator		Operator
hi def link fdfSection		Statement
hi def link dscDefine		Statement
hi def link dscBuildOptions	Statement
" PreProc - Include Define Macro PreCondit
hi def link fdfMacroMatch	fdfMacro
hi def link fdfMacro		Macro
" Type - StorageClass Structure Typedef
hi def link dscType		Type
hi def link fdfFVFileType	Type
" Special - SpecialChar Tag Delimiter SpecialComment Debug
hi def link dscFieldSeparator	Delimiter
" Underlined
" Ignore
" Error
" Todo
hi def link decCFormatGUID	x220_Gold1
hi def link decRegistryFormatGUID	x220_Gold1


let b:current_syntax = "uefidsc"

" vim:ts=8:foldmethod=marker
