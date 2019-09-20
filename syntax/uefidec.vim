" Vim syntax file
" Language:	UEFI DEC
" Maintainer:	Paul Huang
" Last Change:	2016 Dec 27

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"unlet b:current_syntax

syn case match
syn keyword	decSection	Defines Includes Guids Protocols Ppis LibraryClasses PcdsFeatureFlag PcdsFixedAtBuild PcdsPatchableInModule PcdsDynamic PcdsDynamicEx UserExtensions
syn keyword	decDefine	DEC_SPECIFICATION PACKAGE_NAME PACKAGE_GUID PACKAGE_VERSION PACKAGE_UNI_FILE
" Table 2. EDK II Module Types {{{
syn keyword decModuleType	BASE SEC PEI_CORE PEIM DXE_CORE DXE_DRIVER DXE_RUNTIME_DRIVER DXE_SAL_DRIVER DXE_SMM_DRIVER SMM_CORE UEFI_DRIVER UEFI_APPLICATION
" }}}
syn keyword	decBoolean	TRUE true True 0x1 0x01 1 FALSE false False 0x0 0x00 0 
syn keyword	decType		BOOLEAN UINT8 UINT16 UINT32 UINT64 UINT8z UINT16z UINT32z UINT64z
syn match	decTypeMatch	"VOID\*"
syn match	decFieldSeparator	"|" 
syn region	decComment	start="#" end="$" contains=@Spell




syn match	decFileSep	"\/"
syn match	decFile		"\w\(\.\|\w\|\-\)*\.\(\w\|-\)\+"
syn match	decCommaSpace	transparent contained "\,\s+"
syn match	decHexByte	"0\(x\|X\)\x"
syn match	decRegistryFormatGUID	"\x\{8}\-\x\{4}-\x\{4}\-\x\{4}\-\x\{12}"
syn region	decCFormatGUID	start="{\s*0\(x\|X\)\x\{8}\,\s\+" end="0\(x\|X\)\x\{2}\s*\}\s*\}" oneline contains=decCommaSpace
syn match	decNumber	display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"


hi x220_Gold1			ctermfg=220 guifg=#ffd700


" Comment
hi def link decComment		Comment
" Constant - String Character Number Boolean Float
hi def link decNumber		Number
hi def link decBoolean		Boolean
" Identifier - Function
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link decSection		Statement
hi def link decDefine		Statement
" PreProc - Include Define Macro PreCondit
" Type - StorageClass Structure Typedef
hi def link decModuleType	Type
hi def link decTypeMatch	decType
hi def link decType		Type
" Special - SpecialChar Tag Delimiter SpecialComment Debug
hi def link decFieldSeparator	Delimiter
" Underlined
" Ignore
" Error
" Todo
hi def link decCFormatGUID	x220_Gold1
hi def link decRegistryFormatGUID	x220_Gold1


let b:current_syntax = "uefidec"

" vim:ts=8:foldmethod=marker
