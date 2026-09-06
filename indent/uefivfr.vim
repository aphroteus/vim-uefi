vim9script
# Vim indent file
# Language: UEFI VFR (Visual Forms Representation)

if exists("b:did_indent")
  finish
endif
b:did_indent = 1

setlocal cindent

b:undo_indent = "setlocal cindent<"
