vim9script
# Vim filetype detection file for SDL files
# Language: SDL

augroup filetypedetect
  autocmd BufNewFile,BufRead *.sdl setfiletype sdl
augroup END
