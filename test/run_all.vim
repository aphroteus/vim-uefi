vim9script
# Main test suite runner for vim-uefi

import './assert.vim' as t
import './test_autoload.vim' as t_autoload
import './test_ftdetect.vim' as t_ftdetect
import './test_ftplugin.vim' as t_ftplugin
import './test_syntax.vim' as t_syntax

t.Log('==================================================')
t.Log('vim-uefi automated test suite')
t.Log('==================================================')

t_autoload.Run()
t_ftdetect.Run()
t_ftplugin.Run()
t_syntax.Run()

var passed = t.PrintSummary()
if passed
  qall!
else
  cquit!
endif
