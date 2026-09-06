vim9script
# Unit tests for autoload/uefi.vim (uefi#IsUefiC)

import './assert.vim' as t

export def Run()
  t.Log('=== Running test_autoload.vim ===')

  # Test 1: Tier 1 DNA regex patterns
  new
  setline(1, ['#include <stdio.h>', 'DEBUG ((DEBUG_INFO, "test"));'])
  t.AssertTrue('Tier 1: DEBUG with whitespace and (( matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['DEBUG(0);'])
  t.AssertTrue('Tier 1: DEBUG(0) without whitespace matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['MY_DEBUG (0);', 'int x = 0;'])
  t.AssertFalse('Tier 1: MY_DEBUG does not trigger UEFI detection', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['EFI_STATUS Status = EFI_SUCCESS;'])
  t.AssertTrue('Tier 1: EFI_STATUS matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['EFIAPI void MyFunction() {}'])
  t.AssertTrue('Tier 1: EFIAPI matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['gBS->CreateEvent(0, 0, NULL, NULL, &Event);'])
  t.AssertTrue('Tier 1: gBS matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['gPeiServices->InstallPpi(&PpiList);'])
  t.AssertTrue('Tier 1: gPeiServices matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['#include <Uefi.h>'])
  t.AssertTrue('Tier 1: #include <Uefi.h> matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['#include <Library/BaseLib.h>'])
  t.AssertTrue('Tier 1: #include <Library/...> matches', uefi#IsUefiC())
  bwipeout!

  new
  setline(1, ['#include <stdio.h>', 'int main() { return 0; }'])
  t.AssertFalse('Tier 1: Clean standard C file returns false', uefi#IsUefiC())
  bwipeout!

  # Test 2: Cursor neutrality and position preservation
  new
  var dummy_lines = map(range(1, 200), '""')
  setline(1, dummy_lines)
  setline(20, 'EFI_STATUS Status = EFI_SUCCESS;')
  cursor(180, 5)
  var pos_before = getpos('.')
  var detected = uefi#IsUefiC()
  var pos_after = getpos('.')
  t.AssertTrue('Cursor neutrality: detects DNA in first 150 lines regardless of cursor', detected)
  t.Assert('Cursor neutrality: cursor position remains unchanged', pos_after, pos_before)
  bwipeout!

  # Test 3: 150-line boundary limit
  new
  dummy_lines = map(range(1, 200), '""')
  setline(1, dummy_lines)
  setline(160, 'EFI_STATUS Status = EFI_SUCCESS;')
  t.AssertFalse('Boundary: DNA past line 150 does not trigger Tier 1', uefi#IsUefiC())
  bwipeout!

  # Test 4: Unnamed buffer guard
  new
  setline(1, ['#include <stdio.h>', 'int x = 42;'])
  t.AssertTrue('Unnamed buffer: buffer name is empty', empty(expand('%')))
  t.AssertFalse('Unnamed buffer: returns false without triggering getcwd() false positive', uefi#IsUefiC())
  bwipeout!

  # Test 5: Tier 2 Dynamic Fixture (*.inf proximity)
  var tmp_tier2 = tempname()
  mkdir(tmp_tier2 .. '/driver', 'p')
  writefile(['[Defines]', 'INF_VERSION = 0x00010005', 'BASE_NAME = TestDriver'], tmp_tier2 .. '/driver/TestDriver.inf')
  var driver_c = tmp_tier2 .. '/driver/Driver.c'
  writefile(['// Minimal C file with no DNA', 'int value = 1;'], driver_c)
  execute 'edit ' .. fnameescape(driver_c)
  t.AssertTrue('Tier 2: INF proximity check in current directory returns true', uefi#IsUefiC())
  bdelete!
  delete(tmp_tier2, 'rf')

  # Test 6: Tier 3 Dynamic Fixture (Package Include/ and *.dec proximity)
  var tmp_tier3 = tempname()
  mkdir(tmp_tier3 .. '/Include/Library', 'p')
  writefile(['[Defines]', 'DEC_SPECIFICATION = 0x00010005', 'PACKAGE_NAME = TestPkg'], tmp_tier3 .. '/TestPkg.dec')
  var header_h = tmp_tier3 .. '/Include/Library/TestLib.h'
  writefile(['// Public header with no DNA', 'void Foo();'], header_h)
  execute 'edit ' .. fnameescape(header_h)
  t.AssertTrue('Tier 3: DEC proximity check from Include/ returns true', uefi#IsUefiC())
  bdelete!
  delete(tmp_tier3, 'rf')

  # Test 7: Wildcard escaping in filesystem path (e.g. square brackets)
  var tmp_wildcard = tempname() .. '/[special_dir]'
  mkdir(tmp_wildcard, 'p')
  writefile(['[Defines]', 'BASE_NAME = SpecialMod'], tmp_wildcard .. '/Special.inf')
  var special_c = tmp_wildcard .. '/Special.c'
  writefile(['int special = 0;'], special_c)
  execute 'edit ' .. fnameescape(special_c)
  t.AssertTrue('Path escaping: handles square brackets in directory path without glob errors', uefi#IsUefiC())
  bdelete!
  delete(fnamemodify(tmp_wildcard, ':h'), 'rf')
enddef
