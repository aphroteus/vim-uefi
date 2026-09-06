vim9script
# Vim filetype detection file for Log files

augroup filetypedetect
  autocmd BufNewFile,BufRead *.log setfiletype log
augroup END
