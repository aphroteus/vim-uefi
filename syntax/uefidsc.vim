" Vim syntax file
" Language:	UEFI DSC
" Maintainer:	Paul Huang
" Last Change:	2016 Dec 27

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"unlet b:current_syntax

syn case match
syn keyword dscSection		Defines BuildOptions SkuIds Libraries LibraryClasses PcdsFeatureFlag PcdsFixedAtBuild PcdsDynamicDefault PcdsDynamicHII PcdsDynamicVpd PcdsDynamicExDefault PcdsDynamicExHii PcdsDynamicExVpd Components UserExtensions
" Table 6. EDK II [Defines] Section Elements {{{
syn keyword dscDefine		DSC_SPECIFICATION PLATFORM_GUID PLATFORM_VERSION PLATFORM_NAME SKUID_IDENTIFIER SUPPORTED_ARCHITECTURES BUILD_TARGETS OUTPUT_DIRECTORY FLASH_DEFINITION BUILD_NUMBER FIX_LOAD_TOP_MEMORY_ADDRESS TIME_STAMP_FILE DEFINE EDK_GLOBAL RFC_LANGUAGES ISO_LANGUAGES VPD_TOOL_GUID PCD_INFO_GENERATION PCD_VAR_CHECK_GENERATION
" }}}
" Table 7. EDK II [BuildOptions] Section Elements: Optional Tags {{{
syn keyword dscBuildOption	FAMILY TARGET TAGNAME ARCH TOOLCODE ATTRIBUTE
" }}}

syn keyword dscComponent	SOURCE_OVERRIDE_PATH
syn keyword dscBoolean		TRUE true True 0x1 0x01 1 FALSE false False 0x0 0x00 0 
" Table 5. Operator Precedence and Supported Operands {{{
syn keyword dscOperator		or OR and AND xor XOR EQ NE IN LE GE LT GT not NOT
syn match dscOperatorMatch	"||\|&&\||\|==\|!=\|<=\|>=\|<\|>\|+\|-\|!"
" }}}
syn keyword dscType		BOOLEAN UINT8 UINT16 UINT32 UINT64 UINT8z UINT16z UINT32z UINT64z VOID
syn match dscFieldSeparator	"|" 
syn region dscComment		start="#" end="$" contains=@Spell
syn keyword dscStatement	!include
syn match dscConditional	"!\(ifdef\|ifndef\|if\|elseif\|else\|endif\)"
syn region dscVariable		start="\$(" skip="\\)\|\\\\" end=")"



"syn match decFileSep		"\/"
"syn match decFile		"\w\(\.\|\w\|\-\)*\.\(\w\|-\)\+"
"syn match decFilePath		"\(\w\(\w\|\.\|\-\)*\)\(\/\(\w\(\w\|\.\|\-\)*\)\)*\w\(\.\|\w\|\-\)*\.\(\w\|-\)\+"
syn match decCommaSpace		transparent contained "\,\s+"
syn match decRegistryFormatGUID "\x\{8}\-\x\{4}-\x\{4}\-\x\{4}\-\x\{12}"
syn region decCFormatGUID	start="{\s*0\(x\|X\)\x\{8}\,\s\+" end="0\(x\|X\)\x\{2}\s*\}\s*\}" oneline contains=decCommaSpace
syn match decNumber		display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"



hi x203_IndianRed1		ctermfg=203 guifg=#ff5f5f
hi x208_DarkOrange		ctermfg=208 guifg=#ff8700
hi x220_Gold1			ctermfg=220 guifg=#ffd700
hi x228_Khaki1			gui=italic ctermfg=228 guifg=#ffff87


" Comment
hi def link dscComment		Comment
" Constant - String Character Number Boolean Float
hi def link decNumber		Number
hi def link dscBoolean		Boolean
" Identifier - Function
hi def link dscVariable		Identifier
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link dscStatement	Statement
hi def link dscConditional	Conditional
hi def link dscOperatorMatch	dscOperator
hi def link dscOperator		Operator
hi def link dscSection		Statement
hi def link dscDefine		Statement
hi def link dscBuildOption	Statement
hi def link dscComponent	Statement
" PreProc - Include Define Macro PreCondit
" Type - StorageClass Structure Typedef
hi def link dscType		Type
" Special - SpecialChar Tag Delimiter SpecialComment Debug
hi def link dscFieldSeparator	Delimiter
" Underlined
"hi def link decFilePath		Underlined
" Ignore
" Error
" Todo
hi def link decCFormatGUID	x220_Gold1
hi def link decRegistryFormatGUID	x220_Gold1


let b:current_syntax = "uefidsc"

" vim:ts=8:foldmethod=marker
