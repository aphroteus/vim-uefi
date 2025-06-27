" Vim syntax file
" Language:    UEFI INF
" Maintainer:  Paul Huang
" Last Change: 2025 Jun 10

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match
syn keyword infSection                  Defines Sources BuildOptions Binaries Includes Protocols Ppis Guids LibraryClasses Packages FeaturePcd FixedPcd PatchPcd Pcd PcdEx Depex UserExtensions
" Table 1. EDK II [Defines] Section Elements {{{
syn keyword infDefine                   INF_VERSION BASE_NAME EDK_RELEASE_VERSION PI_SPECIFICATION_VERSION UEFI_SPECIFICATION_VERSION FILE_GUID MODULE_TYPE BUILD_NUMBER VERSION_STRING MODULE_UNI_FILE LIBRARY_CLASS PCD_IS_DRIVER ENTRY_POINT UNLOAD_IMAGE CONSTRUCTOR DESTRUCTOR SHADOW PCI_DEVICE_ID PCI_VENDOR_ID PCI_CLASS_CODE PCI_COMPRESS UEFI_HII_RESOURCE_SECTION DEFINE SPEC CUSTOM_MAKEFILE DPX_SOURCE
" }}}
" Table 3. EDK II [BuildOptions] Variable Descriptions {{{
syn keyword infBuildOption              FAMILY TARGET TAGNAME ARCH TOOLCODE ATTRIBUTE
" }}}
" Table 9. EDK II Module Types {{{
syn keyword infModuleType               BASE SEC PEI_CORE PEIM DXE_CORE DXE_DRIVER DXE_RUNTIME_DRIVER DXE_SAL_DRIVER DXE_SMM_DRIVER SMM_CORE UEFI_DRIVER UEFI_APPLICATION USER_DEFINED
" }}}

syn region  infComment                  start="#" end="$" contains=@Spell


" Highlight Default Link {{{
" Comment
hi def link infComment                  Comment
" Constant
" String
" Character
" Number
" Boolean
" Float
" Identifier
" Function
" Statement
" Conditional
" Repeat
" Label
" Operator
" Keyword
hi def link infSection                  Keyword
hi def link infDefine                   Keyword
hi def link infBuildOption              Keyword
" Exception
" PreProc
" Include
" Define
" Macro
" PreCondit
" Type
hi def link infModuleType               Type
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


let b:current_syntax = "uefiinf"

" vim:ts=8:foldmethod=marker
