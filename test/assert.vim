vim9script
# Test assertion and reporting module for vim-uefi test suite

var total_tests = 0
var total_passed = 0
var total_failed = 0
var failure_messages: list<string> = []
var test_log: list<string> = []

def IsTruthy(val: any): bool
  if typename(val) == 'bool'
    return val
  elseif typename(val) == 'number'
    return val != 0
  endif
  return false
enddef

def IsFalsy(val: any): bool
  if typename(val) == 'bool'
    return !val
  elseif typename(val) == 'number'
    return val == 0
  endif
  return false
enddef

export def Log(msg: string)
  add(test_log, msg)
enddef

export def Assert(desc: string, actual: any, expected: any)
  total_tests += 1
  if actual ==# expected
    total_passed += 1
    add(test_log, $'PASS: {desc}')
  else
    total_failed += 1
    var msg = $'FAIL: {desc} (expected: {string(expected)}, got: {string(actual)})'
    add(test_log, msg)
    add(failure_messages, msg)
  endif
enddef

export def AssertTrue(desc: string, actual: any)
  total_tests += 1
  if IsTruthy(actual)
    total_passed += 1
    add(test_log, $'PASS: {desc}')
  else
    total_failed += 1
    var msg = $'FAIL: {desc} (expected true, got: {string(actual)})'
    add(test_log, msg)
    add(failure_messages, msg)
  endif
enddef

export def AssertFalse(desc: string, actual: any)
  total_tests += 1
  if IsFalsy(actual)
    total_passed += 1
    add(test_log, $'PASS: {desc}')
  else
    total_failed += 1
    var msg = $'FAIL: {desc} (expected false, got: {string(actual)})'
    add(test_log, msg)
    add(failure_messages, msg)
  endif
enddef

export def AssertMatch(desc: string, str: string, pat: string)
  total_tests += 1
  if match(str, pat) >= 0
    total_passed += 1
    add(test_log, $'PASS: {desc}')
  else
    total_failed += 1
    var msg = $'FAIL: {desc} (string "{str}" does not match pattern "{pat}")'
    add(test_log, msg)
    add(failure_messages, msg)
  endif
enddef

const repo_root = fnamemodify(expand('<sfile>:p:h:h'), ':p')->substitute('[/\\]$', '', '')

export def PrintSummary(): bool
  add(test_log, '--------------------------------------------------')
  add(test_log, $'Test Results: {total_passed}/{total_tests} passed')
  var success = true
  if total_failed > 0
    add(test_log, $'Failures ({total_failed}):')
    for f in failure_messages
      add(test_log, $'  - {f}')
    endfor
    success = false
  else
    add(test_log, 'All tests passed successfully.')
  endif
  add(test_log, '--------------------------------------------------')

  for msg in test_log
    echomsg msg
  endfor
  writefile(test_log, repo_root .. '/test/test.log')
  return success
enddef
