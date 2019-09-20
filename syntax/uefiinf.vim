" Vim syntax file
" Language:	UEFI INF
" Maintainer:	Paul Huang
" Last Change:	2016 Dec 27

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"unlet b:current_syntax

syn case match
syn keyword	infSection		Defines BuildOptions LibraryClasses Packages Sources UserExtensions Protocols Ppis Guids Depex Binaries
" Table 1. EDK II [Defines] Section Elements {{{
syn keyword	infDefine		INF_VERSION BASE_NAME EDK_RELEASE_VERSION PI_SPECIFICATION_VERSION UEFI_SPECIFICATION_VERSION FILE_GUID MODULE_TYPE BUILD_NUMBER VERSION_STRING MODULE_UNI_FILE LIBRARY_CLASS PCD_IS_DRIVER ENTRY_POINT UNLOAD_IMAGE CONSTRUCTOR DESTRUCTOR SHADOW PCI_DEVICE_ID PCI_VENDOR_ID PCI_CLASS_CODE PCI_COMPRESS UEFI_HII_RESOURCE_SECTION DEFINE SPEC CUSTOM_MAKEFILE DPX_SOURCE
" }}}
" Table 3. EDK II [BuildOptions] Variable Descriptions {{{
syn keyword	infBuildOption	FAMILY TARGET TAGNAME ARCH TOOLCODE ATTRIBUTE
" }}}

syn region	infComment		start="#" end="$" contains=@Spell


" Comment
hi def link infComment		Comment
" Constant - String Character Number Boolean Float
" Identifier - Function
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link infSection		Statement
hi def link infDefine		Statement
hi def link infBuildOption	Statement
" PreProc - Include Define Macro PreCondit
" Type - StorageClass Structure Typedef
" Special - SpecialChar Tag Delimiter SpecialComment Debug
" Underlined
" Ignore
" Error
" Todo




let b:current_syntax = "uefiinf"

" vim:ts=8:foldmethod=marker
