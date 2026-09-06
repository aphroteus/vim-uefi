vim9script
# Vim filetype plugin file for UEFI C
# Language: UEFI C / EDK II

# Re-entrancy guard
if exists('b:did_uefi_c_ftplugin')
  finish
endif

# Configuration guards harmonized with after/syntax/c.vim
var c_mode = string(get(g:, 'uefi_c_syntax', 'auto'))
if get(g:, 'uefi_no_c_ftplugin', 0) || get(g:, 'uefi_no_c_syntax', 0) || c_mode ==# '0' || c_mode ==# "'0'"
  finish
endif

if c_mode !=# '1' && c_mode !=# "'1'"
  if !uefi#IsUefiC()
    finish
  endif
endif

b:did_uefi_c_ftplugin = 1

setlocal commentstring=//\ %s
setlocal formatoptions-=t formatoptions+=croql

b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin .. ' | ' : '') .. "setlocal commentstring< formatoptions< | unlet! b:did_uefi_c_ftplugin"
