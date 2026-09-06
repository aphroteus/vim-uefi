vim9script
# Buffer configuration and undo tests for ftplugin/*.vim and indent/*.vim

import './assert.vim' as t

export def Run()
  t.Log('=== Running test_ftplugin.vim ===')

  # Test 1: Hash-comment filetypes (DEC, DSC, FDF, INF, SDL)
  for ft in ['uefidec', 'uefidsc', 'uefifdf', 'uefiinf', 'sdl']
    new
    execute 'setlocal filetype=' .. ft
    t.Assert($'ftplugin {ft}: commentstring is # %s', &l:commentstring, '# %s')
    t.AssertTrue($'ftplugin {ft}: comments contains #', &l:comments =~# ':#')
    t.AssertTrue($'ftplugin {ft}: b:undo_ftplugin is defined', exists('b:undo_ftplugin'))
    bwipeout!
  endfor

  # Test 2: Double-slash comment filetypes (UNI)
  new
  setlocal filetype=uefiuni
  t.Assert('ftplugin uefiuni: commentstring is // %s', &l:commentstring, '// %s')
  t.AssertTrue('ftplugin uefiuni: comments contains //', &l:comments =~# '://')
  bwipeout!

  # Test 3: C-style comment & indent filetypes (ASL, VFR)
  for ft in ['asl', 'uefivfr']
    new
    execute 'setlocal filetype=' .. ft
    t.Assert($'ftplugin {ft}: commentstring is // %s', &l:commentstring, '// %s')
    t.AssertTrue($'ftplugin {ft}: comments contains /* and //', &l:comments =~# '/\*' && &l:comments =~# '//')
    t.AssertTrue($'indent {ft}: cindent is enabled', &l:cindent)
    t.AssertTrue($'indent {ft}: b:undo_indent contains cindent<', exists('b:undo_indent') && b:undo_indent =~# 'cindent<')
    bwipeout!
  endfor

  # Test 4: UEFI C after/ftplugin/c.vim isolation and activation
  new
  setline(1, ['#include <stdio.h>', 'int main() { return 0; }'])
  setlocal filetype=c
  t.Assert('ftplugin c (plain): commentstring remains default', &l:commentstring, '/* %s */')
  bwipeout!

  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.Assert('ftplugin c (uefi): commentstring is // %s', &l:commentstring, '// %s')
  t.AssertTrue('ftplugin c (uefi): formatoptions does not contain t', &l:formatoptions !~# 't')
  t.AssertTrue('ftplugin c (uefi): formatoptions contains c', &l:formatoptions =~# 'c')
  t.AssertTrue('ftplugin c (uefi): b:undo_ftplugin contains commentstring<', exists('b:undo_ftplugin') && b:undo_ftplugin =~# 'commentstring<')
  bwipeout!

  # Test 4b: after/ftplugin/c.vim re-entrancy guard
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  var undo_orig = b:undo_ftplugin
  runtime after/ftplugin/c.vim
  t.Assert('re-entrancy: b:undo_ftplugin is not duplicated on repeat execution', b:undo_ftplugin, undo_orig)
  bwipeout!

  # Test 4c: after/ftplugin/c.vim configuration guards
  g:uefi_c_syntax = 0
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.Assert('ftplugin c guard: g:uefi_c_syntax = 0 prevents UEFI commentstring', &l:commentstring, '/* %s */')
  t.AssertFalse('ftplugin c guard: b:did_uefi_c_ftplugin not set when disabled', exists('b:did_uefi_c_ftplugin'))
  bwipeout!
  unlet g:uefi_c_syntax

  g:uefi_no_c_syntax = 1
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.Assert('ftplugin c guard: g:uefi_no_c_syntax = 1 prevents UEFI commentstring', &l:commentstring, '/* %s */')
  bwipeout!
  unlet g:uefi_no_c_syntax

  g:uefi_no_c_ftplugin = 1
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.Assert('ftplugin c guard: g:uefi_no_c_ftplugin = 1 prevents UEFI commentstring', &l:commentstring, '/* %s */')
  bwipeout!
  unlet g:uefi_no_c_ftplugin

  g:uefi_c_syntax = 1
  new
  setline(1, ['#include <stdio.h>', 'int main() { return 0; }'])
  setlocal filetype=c
  t.Assert('ftplugin c guard: g:uefi_c_syntax = 1 force-enables // %s for plain C', &l:commentstring, '// %s')
  bwipeout!
  unlet g:uefi_c_syntax

  # Test 4d: execute b:undo_ftplugin restores settings
  new
  setline(1, ['#include <Uefi.h>', 'EFI_STATUS Status = EFI_SUCCESS;'])
  setlocal filetype=c
  t.Assert('undo exec (uefi c): active commentstring is // %s', &l:commentstring, '// %s')
  execute b:undo_ftplugin
  t.Assert('undo exec (uefi c): commentstring restored to /* %s */', &l:commentstring, '/* %s */')
  t.AssertFalse('undo exec (uefi c): b:did_uefi_c_ftplugin is cleared', exists('b:did_uefi_c_ftplugin'))
  bwipeout!

  new
  var global_cms = &g:commentstring
  setlocal filetype=sdl
  t.Assert('undo exec (sdl): active commentstring is # %s', &l:commentstring, '# %s')
  execute b:undo_ftplugin
  t.Assert('undo exec (sdl): commentstring restored to global value', &l:commentstring, global_cms)
  bwipeout!

  # Test 5: Log helper <F5> mapping
  new
  setlocal filetype=log
  t.AssertTrue('ftplugin log: <F5> mapping exists', mapcheck('<F5>', 'n') !=# '')
  bwipeout!

  # Test 5b: Log helper disabled by option
  g:uefi_log_f5_reload = 0
  new
  setlocal filetype=log
  t.Assert('ftplugin log: <F5> mapping not created when disabled', mapcheck('<F5>', 'n'), '')
  bwipeout!
  unlet g:uefi_log_f5_reload

  # Test 6: b:undo_ftplugin chaining preserves pre-existing undo commands
  new
  b:undo_ftplugin = 'let b:pre_existing = 1'
  unlet! b:did_ftplugin
  runtime ftplugin/uefidec.vim
  t.AssertTrue('undo chaining: preserves previous commands', b:undo_ftplugin =~# 'let b:pre_existing = 1')
  t.AssertTrue('undo chaining: appends setlocal with pipe', b:undo_ftplugin =~# ' | setlocal comments<')
  bwipeout!

  # Test 6b: sdl undo chaining
  new
  b:undo_ftplugin = 'let b:pre_existing = 1'
  unlet! b:did_ftplugin
  runtime ftplugin/sdl.vim
  t.AssertTrue('sdl undo chaining: preserves previous commands', b:undo_ftplugin =~# 'let b:pre_existing = 1')
  t.AssertTrue('sdl undo chaining: appends setlocal with pipe', b:undo_ftplugin =~# ' | setlocal comments<')
  bwipeout!
enddef
