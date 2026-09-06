vim9script
# Filetype detection tests for ftdetect/*.vim

import './assert.vim' as t

def CheckFileType(filename: string, expected_ft: string, desc: string)
  execute 'edit ' .. fnameescape(filename)
  t.Assert(desc, &filetype, expected_ft)
  bwipeout!
enddef

export def Run()
  t.Log('=== Running test_ftdetect.vim ===')

  # Test 1: Standard EDK II file extensions
  CheckFileType('test.dec', 'uefidec', 'ftdetect: *.dec sets filetype to uefidec')
  CheckFileType('test.dsc', 'uefidsc', 'ftdetect: *.dsc sets filetype to uefidsc')
  CheckFileType('test.fdf', 'uefifdf', 'ftdetect: *.fdf sets filetype to uefifdf')
  CheckFileType('test.uni', 'uefiuni', 'ftdetect: *.uni sets filetype to uefiuni')
  CheckFileType('test.vfr', 'uefivfr', 'ftdetect: *.vfr sets filetype to uefivfr')
  CheckFileType('test.hfr', 'uefivfr', 'ftdetect: *.hfr sets filetype to uefivfr')

  # Test 2: Standard ASL file extensions
  CheckFileType('test.asl', 'asl', 'ftdetect: *.asl sets filetype to asl')
  CheckFileType('test.asi', 'asl', 'ftdetect: *.asi sets filetype to asl')

  # Test 3: Log files
  CheckFileType('build.log', 'log', 'ftdetect: *.log sets filetype to log')

  # Test 4: System collision overrides
  CheckFileType('Platform.inf', 'uefiinf', 'ftdetect override: *.inf overrides system "inform" to uefiinf')
  CheckFileType('DSDT.dsl', 'asl', 'ftdetect override: *.dsl overrides system "structurizr" to asl')
  CheckFileType('Setup.sd', 'uefivfr', 'ftdetect override: *.sd overrides system "sd" to uefivfr')

  # Test 5: Autocommand group membership
  t.AssertTrue('augroup: uefi rules registered under filetypedetect', exists('#filetypedetect#BufNewFile#*.dec'))
  t.AssertTrue('augroup: asl rules registered under filetypedetect', exists('#filetypedetect#BufNewFile#*.asl'))
  t.AssertTrue('augroup: log rules registered under filetypedetect', exists('#filetypedetect#BufNewFile#*.log'))
enddef
