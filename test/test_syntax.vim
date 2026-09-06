vim9script
# Syntax isolation and mode guard tests for after/syntax/c.vim and syntax/*.vim

import './assert.vim' as t

const repo_root = fnamemodify(expand('<sfile>:p:h:h'), ':p')->substitute('[/\\]$', '', '')

def IsUefiSyntaxActive(): bool
  var syn_info = ''
  try
    syn_info = execute('syntax list ueficDataType')
  catch
    return false
  endtry
  return syn_info =~# 'EFI_STATUS'
enddef

export def Run()
  t.Log('=== Running test_syntax.vim ===')

  # Test 1: Zero-pollution isolation in standard C
  new
  setline(1, ['#include <stdio.h>', 'int main() { printf("Hello World\\n"); return 0; }'])
  setlocal filetype=c
  t.AssertFalse('isolation: plain C file does NOT load UEFI syntax under auto mode', IsUefiSyntaxActive())
  bwipeout!

  # Test 2: Auto-detection activates UEFI syntax when DNA is present
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.AssertTrue('activation: C file with UEFI DNA loads uefic syntax under auto mode', IsUefiSyntaxActive())
  bwipeout!

  # Test 3: Forced enable mode (g:uefi_c_syntax = 1 and '1')
  g:uefi_c_syntax = 1
  new
  setline(1, ['#include <stdio.h>', 'int x = 1;'])
  setlocal filetype=c
  t.AssertTrue('mode guard: g:uefi_c_syntax = 1 force-enables UEFI C syntax for plain C', IsUefiSyntaxActive())
  bwipeout!

  g:uefi_c_syntax = '1'
  new
  setline(1, ['#include <stdio.h>', 'int x = 1;'])
  setlocal filetype=c
  t.AssertTrue('mode guard: g:uefi_c_syntax = "1" (string) force-enables UEFI C syntax', IsUefiSyntaxActive())
  bwipeout!

  # Test 4: Forced disable mode (g:uefi_c_syntax = 0 and '0')
  g:uefi_c_syntax = 0
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.AssertFalse('mode guard: g:uefi_c_syntax = 0 force-disables UEFI C syntax', IsUefiSyntaxActive())
  bwipeout!

  g:uefi_c_syntax = '0'
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.AssertFalse('mode guard: g:uefi_c_syntax = "0" (string) force-disables UEFI C syntax', IsUefiSyntaxActive())
  bwipeout!
  unlet g:uefi_c_syntax

  # Test 5: Legacy disable flag (g:uefi_no_c_syntax = 1)
  g:uefi_no_c_syntax = 1
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.AssertFalse('mode guard: g:uefi_no_c_syntax = 1 disables UEFI C syntax', IsUefiSyntaxActive())
  bwipeout!
  unlet g:uefi_no_c_syntax

  # Test 6: %r and %t conversion specifiers in cFormat
  g:uefi_c_syntax = 1
  new
  setline(1, ['#include <Uefi.h>'])
  setlocal filetype=c
  var cfmt = execute('syntax list cFormat')
  t.AssertTrue('cFormat: contains %r and %t specifiers (pnrt)', cfmt =~# 'pnrt')
  bwipeout!
  unlet g:uefi_c_syntax

  # Test 7: syn sync minlines=50 in syntax files
  for syn_file in ['asl.vim', 'uefidsc.vim', 'uefifdf.vim', 'uefivfr.vim']
    var lines = readfile(repo_root .. '/syntax/' .. syn_file)
    var has_sync = match(lines, '^\s*syn\s\+sync\s\+.*minlines=50') >= 0
    t.AssertTrue($'syn sync: {syn_file} contains syn sync minlines=50', has_sync)
  endfor
enddef
