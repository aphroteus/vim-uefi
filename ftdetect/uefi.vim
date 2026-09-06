vim9script
# Vim filetype detection file for UEFI files
# Language: UEFI DEC/DSC/FDF/INF/UNI/VFR

augroup filetypedetect
  autocmd BufNewFile,BufRead *.dec            setfiletype uefidec
  autocmd BufNewFile,BufRead *.dsc            setfiletype uefidsc
  autocmd BufNewFile,BufRead *.fdf            setfiletype uefifdf
  # Vim's system filetype.vim defaults *.inf to 'inform'; override it for UEFI
  autocmd BufNewFile,BufRead *.inf            set filetype=uefiinf
  autocmd BufNewFile,BufRead *.uni            setfiletype uefiuni
  autocmd BufNewFile,BufRead *.vfr,*.hfr      setfiletype uefivfr
  # Vim's system filetype.vim defaults *.sd to 'sd'; override it for Aptio setup files
  autocmd BufNewFile,BufRead *.sd             set filetype=uefivfr
augroup END
