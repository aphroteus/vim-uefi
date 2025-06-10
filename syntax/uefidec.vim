" Vim syntax file
" Language:    UEFI DEC
" Maintainer:  Paul Huang
" Last Change: 2025 Jun 10

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match
syn keyword decSection                  Defines Includes Guids Protocols Ppis LibraryClasses PcdsFeatureFlag PcdsFixedAtBuild PcdsPatchableInModule PcdsDynamic PcdsDynamicEx UserExtensions
syn keyword decDefine                   DEC_SPECIFICATION PACKAGE_NAME PACKAGE_GUID PACKAGE_VERSION PACKAGE_UNI_FILE
" Table 2. EDK II Module Types {{{
syn keyword decModuleType               BASE SEC PEI_CORE PEIM DXE_CORE DXE_DRIVER DXE_RUNTIME_DRIVER DXE_SAL_DRIVER DXE_SMM_DRIVER SMM_CORE UEFI_DRIVER UEFI_APPLICATION
" }}}
syn keyword decBoolean                  TRUE true True 0x1 0x01 1 FALSE false False 0x0 0x00 0
syn keyword decType                     BOOLEAN UINT8 UINT16 UINT32 UINT64 UINT8z UINT16z UINT32z UINT64z
syn match   decTypeMatch                "VOID\*"
syn match   decFieldSeparator           "|"
syn region  decComment                  start="#" end="$" contains=@Spell

syn match   decFileSep                  "\/"
syn match   decFile                     "\w\(\.\|\w\|\-\)*\.\(\w\|-\)\+"
syn match   decCommaSpace               transparent contained "\,\s+"
syn match   decHexByte                  "0\(x\|X\)\x"
syn match   decRegistryFormatGUID       "\x\{8}\-\x\{4}-\x\{4}\-\x\{4}\-\x\{12}"
syn region  decCFormatGUID              start="{\s*0\(x\|X\)\x\{8}\,\s\+" end="0\(x\|X\)\x\{2}\s*\}\s*\}" oneline contains=decCommaSpace
syn match   decNumber                   display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"


" Highlight Default Link {{{
" Comment
hi def link decComment                  Comment
" Constant
" String
" Character
" Number
hi def link decNumber                   Number
" Boolean
hi def link decBoolean                  Boolean
" Float
" Identifier
hi def link decCFormatGUID              Identifier
hi def link decRegistryFormatGUID       Identifier
" Function
" Statement
hi def link decSection                  Statement
hi def link decDefine                   Statement
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
hi def link decModuleType               Type
hi def link decTypeMatch                decType
hi def link decType                     Type
" StorageClass
" Structure
" Typedef
" Special
" SpecialChar
" Tag
" Delimiter
hi def link decFieldSeparator           Delimiter
" SpecialComment
" Debug
" Underlined
" Ignore
" Error
" Todo
" }}}


let b:current_syntax = "uefidec"

" vim:ts=8:foldmethod=marker
