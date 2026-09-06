vim9script
# Vim filetype detection file for ACPI Source Language
# Language: ASL

augroup filetypedetect
  autocmd BufNewFile,BufRead *.asl,*.asi setfiletype asl
  # Vim's system filetype.vim defaults *.dsl to 'structurizr'; override it for ASL
  autocmd BufNewFile,BufRead *.dsl       set filetype=asl
augroup END
