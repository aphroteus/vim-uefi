" Vim syntax file
" Language:    ACPI Source Language
" Maintainer:  Paul Huang
" Last Change: 2025 Jun 12

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" acpi extensions
" Refer to ACPI Specification version 6.6
syn case ignore
" 5.6.8 Predefined ACPI Names for Objects, Methods, and Resources {{{
syn keyword aslPredefined               _AC0 _AC1 _AC2 _AC3 _AC4 _AC5 _AC6 _AC7 _AC8 _AC9 _ADR _AEI _ALC _ALI _ALN _ALP _ALR _ALT _AL0 _AL1 _AL2 _AL3 _AL4 _AL5 _AL6 _AL7 _AL8 _AL9 _ART _ASI _ASZ _ATT _BAS _BBN _BCL _BCM _BCT _BDN _BIF _BIX _BLT _BM _BMA _BMC _BMD _BMS _BPC _BPS _BPT _BQC _BST _BTH _BTM _BTP _CBA _CCA _CDM _CID _CLS _CPC _CRS _CRT _CSD _CST _CWS _DBT _DCK _DCS _DDC _DDN _DEC _DEP _DGS _DIS _DLM _DMA _DOD _DOS _DPL _DRS _DSD _DSM _DSS _DSW _DTI _Exx _EC _EDL _EJD _EJ0 _EJ1 _EJ2 _EJ3 _EJ4 _END _EVT _FDE _FDI _FDM _FIF _FIT _FIX _FLC _FPS _FSL _FST _GAI _GCP _GHL _GL _GLK _GPD _GPE _GRA _GRT _GSB _GTF _GTM _GWS _HE _HID _HMA _HOT _HPP _HPX _HRV _IFT _INI _INT _IOR _IRC _Lxx _LCK _LEN _LID _LIN _LL _LPI _LSI _LSR _LSW _MAF _MAT _MAX _MBM _MEM _MIF _MIN _MLS _MOD _MSG _MSM _MTL _MTP _NTT _OFF _ON _OS _OSC _OSI _OST _PAI _PAR _PCL _PCT _PDC _PDL _PHA _PIC _PIF _PIN _PLD _PMC _PMD _PMM _POL _PPC _PPE _PPI _PR _PR0 _PR1 _PR2 _PR3 _PRE _PRL _PRR _PRS _PRT _PRW _PS0 _PS1 _PS2 _PS3 _PSC _PSD _PSE _PSL _PSR _PSS _PSV _PSW _PTC _PTP _PTS _PUR _PXM _Qxx _RBO _RBW _RDI _REG _REV _RMV _RNG _ROM _RST _RT _RTV _RW _RXL _S0 _S1 _S2 _S3 _S4 _S5 _S1D _S2D _S3D _S4D _S0W _S1W _S2W _S3W _S4W _SB _SBS _SCP _SDD _SEG _SHL _SHR _SI _SIZ _SLI _SLV _SPD _SPE _SRS _SRT _SRV _SST _STA _STB _STM _STP _STR _STV _SUB _SUN _SWS _T_0 _TC1 _TC2 _TDL _TFP _TIP _TIV _TMP _TPC _TPT _TRA _TRS _TRT _TSD _TSF _TSN _TSP _TSS _TST _TTP _TTS _TXL _TYP _TZ _TZD _TZM _TZP _UID _UPC _UPD _UPP _VEN _VPO _WAK _WPC _WPP _Wxx
" TODO _Exx Lxx _Qxx _Wxx
" }}}

" 19.2 ASL Language Grammar {{{
syn region  aslCommentL                 start="//" skip="\\$" end="$" keepend
syn region  aslComment                  start="/\*" end="\*/"
" }}}

" 19.2.7 ASL Parameter Keyword Terms {{{
syn keyword aslAccessAttrib             AttribQuick AttribSendReceive AttribByte AttribBytes AttribRawBytes AttribRawProcessBytes AttribWord AttribBlock AttribProcessCall AttribBlockProcessCall
syn keyword aslAccessType               AnyAcc ByteAcc WordAcc DWordAcc QWordAcc BufferAcc
syn keyword aslAddress                  AddressRangeMemory AddressRangeReserved AddressRangeNVS AddressRangeACPI
" syn keyword aslAddressSpace             aslRegionSpace
syn keyword aslAddressingMode           AddressingMode7Bit AddressingMode10Bit
syn keyword aslByteLength               DataBitsFive DataBitsSix DataBitsSeven DataBitsEight DataBitsNine
syn keyword aslBusMaster                BusMaster NotBusMaster
syn keyword aslClockPhase               ClockPhaseFirst ClockPhaseSecond
syn keyword aslClockPolarity            ClockPolarityLow ClockPolarityHigh
syn keyword aslDecode                   SubDecode PosDecode
syn keyword aslEndian                   BigEndianing LittleEndian
syn keyword aslExtendedAccessAttrib     AttribBytes AttribRawBytes AttribRawProcessBytes
syn keyword aslFlowControl              FlowControlNone FlowControlXon FlowControlHardware
syn keyword aslInterruptType            Edge Level
syn keyword aslInterruptLevel           ActiveHigh ActiveLow ActiveBoth
syn keyword aslIODecode                 Decode16 Decode10
syn keyword aslIoRestriction            IoRestrictionNone IoRestrictionInputOnly IoRestrictionOutputOnly IoRestrictionNoneAndPreserve
syn keyword aslLockRule                 Lock NoLock
syn keyword aslMatchOp                  MTR MEQ MLE MLT MGE MGT
syn keyword aslMax                      MaxFixed MaxNotFixed
syn keyword aslMemType                  Cacheable WriteCombining Prefetchable NonCacheable
syn keyword aslMin                      MinFixed MinNotFixed
syn keyword aslObjectType               UnknownObj IntObj StrObj BuffObj PkgObj FieldUnitObj DeviceObj EventObj MethodObj MutexObj OpRegionObj PowerResObj ProcessorObj ThermalZoneObj BuffFieldObj
syn keyword aslParity                   ParityTypeNone ParityTypeSpace ParityTypeMark ParityTypeOdd ParityTypeEven
syn keyword aslPinConfig                PullDefault PullUp PullDown PullNone
syn keyword aslPolarity                 PolarityHigh PolarityLow
syn keyword aslRangeType                ISAOnlyRanges NonISAOnlyRanges EntireRange
syn keyword aslReadWrite                ReadWrite ReadOnly
syn keyword aslRegionSpace              SystemIO SystemMemory PCI_Config EmbeddedControl SMBus SystemCMOS PciBarTarget IPMI GeneralPurposeIO GenericSerialBus PCC PRM FFixedHW
syn keyword aslResourceType             ResourceConsumer ResourceProducer
syn keyword aslSerializeRule            Serialized NotSerialized
syn keyword aslShareType                Shared Exclusive SharedAndWake ExclusiveAndWake
syn keyword aslSlaveMode                ControllerInitiated DeviceInitiated
syn keyword aslStopBits                 StopBitsZero StopBitsOne StopBitsOnePlusHalf StopBitsTwo
syn keyword aslTransferWidth            Width8Bit Width16Bit Width32Bit Width64Bit Width128Bit Width256Bit
syn keyword aslTranslation              SparseTranslation DenseTranslation
syn keyword aslType                     TypeTranslation TypeStatic
syn keyword aslUpdateRule               Preserve WriteAsOnes WriteAsZeros
syn keyword aslXferType                 Transfer8 Transfer16 Transfer8_16
syn keyword aslWireMode                 ThreeWireMode FourWireMode
" }}}

" 19.3.1 ASL Names {{{
syn match   aslName                     "\<\([A-Z]\|_\)\([A-Z]\|\d\|_\)\{3\}\>"
" }}}

" 19.3.2.1 Integers {{{
syn match   aslNumber                   "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match   aslNumber                   "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
" }}}

" 19.3.2.2 Strings {{{
syn region  aslString                   start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"+ end=+"+
" }}}

" 19.5 ASL Operator Summary by type {{{
" Table 19.16: ASL compiler controls {{{
syn keyword aslInclude                  External Include
" }}}
" Table 19.17: ACPI table management {{{
syn keyword aslTblManagement            DefinitionBlock LoadTable Load
" }}}
" Table 19.18: Miscellaneous named object creation {{{
syn keyword aslNameObj                  Alias Buffer Device Function Method Name Package PowerResource Processor RawDataBuffer Scope ThermalZone
" }}}
" Table 19.19: Operation Regions and Fields {{{
syn keyword aslOpRegionField            AccessAs BankField Connection DataTableRegion Field IndexField Offset OperationRegion
" }}}
" Table 19.20: Buffer Fields {{{
syn keyword aslBufferField              CreateBitField CreateByteField CreateDWordField CreateField CreateQWordField CreateWordField
" }}}
" Table 19.21: Synchronization {{{
syn keyword aslSync                     Acquire Event Mutex Notify Release Reset Signal Wait
" }}}
" Table 19.22: Object references {{{
syn keyword aslObjRef                   CondRefOf DerefOf RefOf
" }}}
" Table 19.23: Integer arithmetic {{{
syn keyword aslArithmetic               Add And Decrement Divide FindSetLeftBit FindSetRightBit Increment Mod Multiply NAnd NOr Not Or ShiftLeft ShiftRight Subtract Xor
" }}}
" Table 19.24: Logical operators {{{
syn keyword aslLogical                  LAnd LEqual LGreater LGreaterEqual LLess LLessEqual LNot LNotEqual LOr
" }}}
" Table 19.25: Method execution control {{{
syn keyword aslControl                  Break BreakPoint Case Continue Default Else ElseIf Fatal If NoOp Return Sleep Stall Switch While
" }}}
" Table 19.26: Data type conversion and manipulation {{{
syn keyword aslDataTypeConv             Concatenate CopyObject Debug EisaId Fprintf FromBCD Index Match Mid ObjectType Printf SizeOf Store Timer ToBCD ToBuffer ToDecimalString ToHexString ToInteger ToPLD ToString ToUUID Unicode
" }}}
" Table 19.27: Resource Descriptor macros {{{
syn keyword aslMacro                    ConcatenateResTemplate DMA DWordIO DWordMemory DWordSpace EndDependentFn ExtendedIO ExtendedMemory ExtendedSpace FixedDMA FixedIO GpioInt GpioIO I2CSerialBusV2 Interrupt IO IRQ IRQNoFlags Memory24 Memory32 Memory32Fixed QWordIO QWordMemory QWordSpace Register ResourceTemplate SPISerialBusV2 StartDependentFn StartDependentFnNoPri UARTSerialBusV2 VendorLong VendorShort WordBusNumber WordIO WordSpace
" }}}
" Table 19.28: Constants {{{
syn keyword aslConstant                 One Ones Revision Zero
" }}}
" Table 19.29: Control method objects {{{
syn keyword aslControlMethodObj         Arg0 Arg1 Arg2 Arg3 Arg4 Arg5 Arg6 Local0 Local1 Local2 Local3 Local4 Local5 Local6 Local7
" }}}
" }}}


" Highlight Default Link {{{
" Comment
hi def link aslCommentL                 aslComment
hi def link aslComment                  Comment
" Constant
hi def link aslConstant                 Constant
" String
hi def link aslString                   String
" Character
" Number
hi def link aslNumber                   Number
" Boolean
" Float
" Identifier
" Function
" Statement
hi def link aslTblManagement            Statement
hi def link aslNameObj                  Statement
hi def link aslOpRegionField            Statement
hi def link aslBufferField              Statement
hi def link aslSync                     Statement
hi def link aslObjRef                   Statement
hi def link aslControl                  Statement
hi def link aslDataTypeConv             Statement
" Conditional
" Repeat
" Label
" Operator
hi def link aslArithmetic               Operator
hi def link aslLogical                  Operator
" Keyword
hi def link aslPredefined               Keyword
hi def link aslControlMethodObj         Keyword
hi def link aslAccessAttrib             Keyword
hi def link aslAccessType               Keyword
hi def link aslAddress                  Keyword
" hi def link aslAddressSpace             Keyword
hi def link aslAddressingMode           Keyword
hi def link aslByteLength               Keyword
hi def link aslBusMaster                Keyword
hi def link aslClockPhase               Keyword
hi def link aslClockPolarity            Keyword
hi def link aslDecode                   Keyword
hi def link aslEndian                   Keyword
hi def link aslExtendedAccessAttrib     Keyword
hi def link aslFlowControl              Keyword
hi def link aslInterruptType            Keyword
hi def link aslInterruptLevel           Keyword
hi def link aslIODecode                 Keyword
hi def link aslIoRestriction            Keyword
hi def link aslLockRule                 Keyword
hi def link aslMatchOp                  Keyword
hi def link aslMax                      Keyword
hi def link aslMemType                  Keyword
hi def link aslMin                      Keyword
hi def link aslObjectType               Keyword
hi def link aslParity                   Keyword
hi def link aslPinConfig                Keyword
hi def link aslPolarity                 Keyword
hi def link aslRangeType                Keyword
hi def link aslReadWrite                Keyword
hi def link aslRegionSpace              Keyword
hi def link aslResourceType             Keyword
hi def link aslSerializeRule            Keyword
hi def link aslShareType                Keyword
hi def link aslSlaveMode                Keyword
hi def link aslStopBits                 Keyword
hi def link aslTransferWidth            Keyword
hi def link aslTranslation              Keyword
hi def link aslType                     Keyword
hi def link aslUpdateRule               Keyword
hi def link aslUserDefRegionSpace       Keyword
hi def link aslXferType                 Keyword
hi def link aslWireMode                 Keyword
" Exception
" PreProc
" Include
hi def link aslInclude                  Include
" Define
" Macro
hi def link aslMacro                    Macro
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


let b:current_syntax = "asl"

" vim:ts=8:foldmethod=marker
