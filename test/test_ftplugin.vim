vim9script
# Buffer configuration and undo tests for ftplugin/*.vim and indent/*.vim

import './assert.vim' as t

export def Run()
  t.Log('=== Running test_ftplugin.vim ===')

  # Test 1: EDK II Hash-comment filetypes (DEC, DSC, FDF, INF)
  for ft in ['uefidec', 'uefidsc', 'uefifdf', 'uefiinf']
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

  # Test 4: Log helper <F5> mapping
  new
  setlocal filetype=log
  t.AssertTrue('ftplugin log: <F5> mapping exists', mapcheck('<F5>', 'n') !=# '')
  bwipeout!

  # Test 4b: Log helper disabled by option
  g:uefi_log_f5_reload = 0
  new
  setlocal filetype=log
  t.Assert('ftplugin log: <F5> mapping not created when disabled', mapcheck('<F5>', 'n'), '')
  bwipeout!
  unlet g:uefi_log_f5_reload

  # Test 5: b:undo_ftplugin chaining preserves pre-existing undo commands
  new
  b:undo_ftplugin = 'let b:pre_existing = 1'
  unlet! b:did_ftplugin
  runtime ftplugin/uefidec.vim
  t.AssertTrue('undo chaining: preserves previous commands', b:undo_ftplugin =~# 'let b:pre_existing = 1')
  t.AssertTrue('undo chaining: appends setlocal with pipe', b:undo_ftplugin =~# ' | setlocal comments<')
  bwipeout!
enddef
