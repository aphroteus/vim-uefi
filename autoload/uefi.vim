vim9script
# Vim autoload file for UEFI context detection
# Language: UEFI C / EDK II

# Universal UEFI / EDK II DNA patterns
const UEFI_DNA_PATTERN = '\C\%(\<DEBUG\s*(\|\<\%(EFI_[A-Z0-9_]\+\|EFIAPI\|g[A-Z0-9_]\+Guid\|g\%(BS\|ST\|RT\|Smst\|Mmst\|PeiServices\)\|PcdGet\w*\|FixedPcdGet\w*\|FeaturePcdGet\w*\|ASSERT_EFI_ERROR\|STATIC\s\+VOID\|UINTN\|INTN\)\>\)'
const UEFI_INC_PATTERN = '^\s*#\s*include\s*[<"]\%(Uefi\|Pi\|Library/\|Protocol/\|Ppi/\|Guid/\|IndustryStandard/\|Base\.h\)'

def HasFile(dir: string, pat: string): bool
  return isdirectory(dir) && !empty(readdir(dir, (fn) => fn =~? pat))
enddef

export def IsUefiC(): bool
  # 0. Check buffer cache to avoid repeated inspection
  if exists("b:uefi_is_uefi_c")
    return b:uefi_is_uefi_c
  endif

  # 1. In-memory buffer DNA search (scans first 150 lines, < 0.5ms, 0 disk I/O)
  var lines = getline(1, 150)
  if match(lines, UEFI_DNA_PATTERN) >= 0 || match(lines, UEFI_INC_PATTERN) >= 0
    b:uefi_is_uefi_c = true
    return true
  endif

  # Unnamed buffer guard: expand('%:p:h') returns getcwd() for unnamed buffers
  if empty(expand('%')) | b:uefi_is_uefi_c = false | return false | endif

  # 2. Local module INF check (inspects immediate folder or parent folder)
  var file_dir = expand('%:p:h')
  if HasFile(file_dir, '\.inf$') || HasFile(file_dir .. '/..', '\.inf$')
    b:uefi_is_uefi_c = true
    return true
  endif

  # 3. Package DEC check for public headers in Include/
  var file_path = expand('%:p')
  if file_path =~? '[/\\\\]Include[/\\\\]'
    if HasFile(file_dir .. '/..', '\.dec$') || HasFile(file_dir .. '/../..', '\.dec$')
      b:uefi_is_uefi_c = true
      return true
    endif
  endif

  # Not in UEFI context: clean standard C
  b:uefi_is_uefi_c = false
  return false
enddef
