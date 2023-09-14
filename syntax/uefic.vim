" Vim syntax file
" Language:	UEFI C
" Maintainer:	Paul Huang
" Last Change:	2023 Sep 13

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
runtime! syntax/c.vim
unlet b:current_syntax

" uefic extensions
" Refer to UEFI Specification version 2.9
" 2.1.1 UEFI Images Table 2-1 UEFI Image Memory Types {{{
syn keyword	ueficImageMemoryType	EFI_IMAGE_SUBSYSTEM_EFI_APPLICATION EFI_IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER EFI_IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER
" }}}

" 2.3.1 Data Types {{{1
" Table 2-3 Common UEFI Data Types {{{2
syn keyword	ueficDataType		BOOLEAN INTN UINTN INT8 UINT8 INT16 UINT16 INT32 UINT32 INT64 UINT64 CHAR8 CHAR16 VOID EFI_GUID EFI_STATUS EFI_HANDLE EFI_EVENT EFI_LBA EFI_TPL EFI_MAC_ADDRESS EFI_IPv4_ADDRESS EFI_IPv6_ADDRESS EFI_IP_ADDRESS
" }}}2
" Table 2-4 Modifiers for Common UEFI Data Types {{{2
syn keyword	ueficModifier		IN OUT OPTIONAL CONST EFIAPI
" }}}2
syn keyword	ueficBoolean		TRUE FALSE
" }}}1

" 2.3.6.1 Memory types {{{1
" Table 2-5 Map: EFI Cacheability Attributes to AArch64 Memory Types {{{2
syn keyword ueficAArch64MemoryType	EFI_MEMORY_UC EFI_MEMORY_WC EFI_MEMORY_WT EFI_MEMORY_WB EFI_MEMORY_UCE
" }}}2
" Table 2-6 Map: UEFI Permission Attributes to ARM Paging Attributes {{{2
syn keyword ueficArmPagingAttribute	EFI_MEMORY_XP EFI_MEMORY_RO EFI_MEMORY_RP EFI_MEMORY_WP
" }}}2
" }}}1

" Table 2-10 UEFI Protocols {{{
syn keyword	ueficProtocol		EFI_LOADED_IMAGE_PROTOCOL EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL EFI_DEVICE_PATH_PROTOCOL EFI_DRIVER_BINDING_PROTOCOL EFI_DRIVER_FAMILY_OVERRIDE_PROTOCOL EFI_PLATFORM_DRIVER_OVERRIDE_PROTOCOL EFI_BUS_SPECIFIC_DRIVER_OVERRIDE_PROTOCOL EFI_DRIVER_DIAGNOSTICS2_PROTOCOL EFI_COMPONENT_NAME2_PROTOCOL EFI_SIMPLE_TEXT_INPUT_PROTOCOL EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL EFI_SIMPLE_POINTER_PROTOCOL EFI_SERIAL_IO_PROTOCOL EFI_LOAD_FILE_PROTOCOL EFI_LOAD_FILE2_PROTOCOL EFI_SIMPLE_FILE_SYSTEM_PROTOCOL EFI_FILE_PROTOCOL EFI_DISK_IO_PROTOCOL EFI_BLOCK_IO_PROTOCOL EFI_BLOCK_IO2_PROTOCOL EFI_UNICODE_COLLATION_PROTOCOL EFI_PCI_ROOT_BRIDGE_IO_PROTOCOL EFI_PCI_IO_PROTOCOL EFI_USB_IO_PROTOCOL EFI_SIMPLE_NETWORK_PROTOCOL EFI_PXE_BASE_CODE_PROTOCOL EFI_BIS_PROTOCOL EFI_DEBUG_SUPPORT_PROTOCOL EFI_DEBUGPORT_PROTOCOL EFI_DECOMPRESS_PROTOCOL EFI_EBC_PROTOCOL EFI_GRAPHICS_OUTPUT_PROTOCOL EFI_NVM_EXPRESS_PASS_THRU_PROTOCOL EFI_EXT_SCSI_PASS_THRU_PROTOCOL EFI_USB2_HC_PROTOCOL EFI_AUTHENTICATION_INFO_PROTOCOL EFI_DEVICE_PATH_UTILITIES_PROTOCOL EFI_DEVICE_PATH_TO_TEXT_PROTOCOL EFI_DEVICE_PATH_FROM_TEXT_PROTOCOL EFI_EDID_DISCOVERED_PROTOCOL EFI_EDID_ACTIVE_PROTOCOL EFI_EDID_OVERRIDE_PROTOCOL EFI_ISCSI_INITIATOR_NAME_PROTOCOL EFI_TAPE_IO_PROTOCOL EFI_MANAGED_NETWORK_PROTOCOL EFI_ARP_SERVICE_BINDING_PROTOCOL EFI_ARP_PROTOCOL EFI_DHCP4_SERVICE_BINDING_PROTOCOL EFI_DHCP4_PROTOCOL EFI_TCP4_SERVICE_BINDING_PROTOCOL EFI_TCP4_PROTOCOL EFI_IP4_SERVICE_BINDING_PROTOCOL EFI_IP4_PROTOCOL EFI_IP4_CONFIG_PROTOCOL EFI_IP4_CONFIG2_PROTOCOL EFI_UDP4_SERVICE_BINDING_PROTOCOL EFI_UDP4_PROTOCOL EFI_MTFTP4_SERVICE_BINDING_PROTOCOL EFI_MTFTP4_PROTOCOL EFI_HASH_PROTOCOL EFI_HASH_SERVICE_BINDING_PROTOCOL EFI_SD_MMC_PASS_THRU_PROTOCOL
syn match	ueficProtocolMatch	"\<EFI_\(\u\|_\|\d\)\+_PROTOCOL\>" contained
" }}}

" Table 2-11 Required UEFI Implementation Elements {{{
syn keyword	ueficImplementationElement	EFI_SYSTEM_TABLE EFI_BOOT_SERVICES EFI_RUNTIME_SERVICES EFI_LOADED_IMAGE_PROTOCOL EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL EFI_DEVICE_PATH_PROTOCOL EFI_DECOMPRESS_PROTOCOL EFI_DEVICE_PATH_UTILITIES_PROTOCOL
" }}}

" Table 3-1 Global Variables {{{
syn keyword	ueficGlobalVariable	AuditMode BootCurrent BootNext BootOrder BootOptionSupport ConIn ConInDev ConOut ConOutDev dbDefault dbrDefault dbtDefault dbxDefault DeployedMode DriverOrder ErrOut ErrOutDev HwErrRecSupport KEK KEKDefault Lang LangCodes OsIndications OsIndicationsSupported OsRecoveryOrder PK PKDefault PlatformLangCodes PlatformLang SignatureSupport SecureBoot SetupMode SysPrepOrder Timeout VendorKeys
" Boot####
" Driver####
" Key####
" PlatformRecovery####
" SysPrep####
syn match ueficGlobalVariableMatch display	"\<g\w\+Guid\>"
" }}}

" GUID {{{
" }}}

" Table 7-2 TPL Usage {{{
syn keyword	ueficTPLUsage		TPL_APPLICATION TPL_CALLBACK TPL_NOTIFY TPL_HIGH_LEVEL
" }}}

" Table D-2 EFI_STATUS Success Codes {{{
syn keyword	ueficEfiStatusSuccess	EFI_SUCCESS
" }}}

" Table D-3 EFI_STATUS Error Codes {{{
syn keyword	ueficEfiStatusError	EFI_LOAD_ERROR EFI_INVALID_PARAMETER EFI_UNSUPPORTED EFI_BAD_BUFFER_SIZE EFI_BUFFER_TOO_SMALL EFI_NOT_READY EFI_DEVICE_ERROR EFI_WRITE_PROTECTED EFI_OUT_OF_RESOURCES EFI_VOLUME_CORRUPTED EFI_VOLUME_FULL EFI_NO_MEDIA EFI_MEDIA_CHANGED EFI_NOT_FOUND EFI_ACCESS_DENIED EFI_NO_RESPONSE EFI_NO_MAPPING EFI_TIMEOUT EFI_NOT_STARTED EFI_ALREADY_STARTED EFI_ABORTED EFI_ICMP_ERROR EFI_TFTP_ERROR EFI_PROTOCOL_ERROR EFI_INCOMPATIBLE_VERSION EFI_SECURITY_VIOLATION EFI_CRC_ERROR EFI_END_OF_MEDIA EFI_END_OF_FILE EFI_INVALID_LANGUAGE EFI_COMPROMISED_DATA EFI_IP_ADDRESS_CONFLICT EFI_HTTP_ERROR
" }}}

" Table D-4 EFI_STATUS Warning Codes {{{
syn keyword	ueficEfiStatusWarning	EFI_WARN_UNKNOWN_GLYPH EFI_WARN_DELETE_FAILURE EFI_WARN_WRITE_FAILURE EFI_WARN_BUFFER_TOO_SMALL EFI_WARN_STALE_DATA EFI_WARN_FILE_SYSTEM EFI_WARN_RESET_REQUIRED
" }}}

syn match	ueficTypeMacro		"\<\u\(\u\|_\|\d\)\+\>"

syn match	ueficSystemTable	"\<g\(BS\|RT\|ST\)\>"
syn match	ueficFunction		"\<\w\+\s*(\@=" contains=cParen

syn match	ueficOperator		"[!~*&%<>^|=+-]"
syn match	ueficOperator		"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match	ueficOperator		"<<\|>>\|&&\|||\|++\|--\|->"


hi x203_IndianRed1			ctermfg=203 guifg=#ff5f5f
hi x220_Gold1				ctermfg=220 guifg=#ffd700

" Comment
" Constant - String Character Number Boolean Float
hi def link ueficGlobalVariableMatch	ueficGlobalVariable
hi def link ueficGlobalVariable		Constant
hi def link ueficTPLUsage		Constant
hi def link ueficEfiStatusSuccess	Constant
hi def link ueficBoolean		Boolean
" Identifier - Function
hi def link ueficSystemTable		ueficFunction
hi def link ueficFunction		Function
" Statement - Conditional Repeat Label Operator Keyword Exception
hi def link ueficOperator		Operator
" PreProc - Include Define Macro PreCondit
" Type - StorageClass Structure Typedef
hi def link ueficImageMemoryType	Type
hi def link ueficDataType		Type
hi def link ueficModifier		Type
hi def link ueficAArch64MemoryType	Type
hi def link ueficArmPagingAttribute	Type
hi def link ueficImplementationElement	Structure
hi def link ueficProtocolMatch		ueficProtocol
hi def link ueficProtocol		Typedef
hi def link ueficTypeMacro		Typedef
" Special - SpecialChar Tag Delimiter SpecialComment Debug
" Underlined
" Ignore
" Error
" Todo
hi def link ueficEfiStatusError		x203_IndianRed1
hi def link ueficEfiStatusWarning	x203_IndianRed1


let b:current_syntax = "uefic"

" vim:ts=8:foldmethod=marker
