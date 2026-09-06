vim9script
# Vim filetype plugin file for Log files

if exists("b:did_ftplugin")
  finish
endif
b:did_ftplugin = 1

if get(g:, 'uefi_log_f5_reload', 1)
  nnoremap <buffer> <silent> <F5> <Cmd>edit<CR>G
  b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin .. ' | ' : '') .. "nunmap <buffer> <F5>"
endif
