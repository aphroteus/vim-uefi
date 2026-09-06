vim9script
# Vim filetype plugin file
# Language: UEFI DSC (Platform Description File)

if exists("b:did_ftplugin")
  finish
endif
b:did_ftplugin = 1

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions-=t formatoptions+=croql

b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin .. ' | ' : '') .. "setlocal comments< commentstring< formatoptions<"
