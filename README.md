# vim-uefi

`vim-uefi` provides syntax highlighting, automatic indentation, comment configuration, and filetype detection for files commonly used in UEFI BIOS development (EDK II and ACPI Source Language).

Implemented in modern **Vim9 script**, conforming to standard Vim runtime engineering practices.

## Features

- **Filetype Detection & Syntax Highlighting**:
  - EDK II Package Declaration (`*.dec`)
  - EDK II Platform Description (`*.dsc`)
  - EDK II Flash Description (`*.fdf`)
  - EDK II Module Information (`*.inf`)
  - UEFI HII String / Unicode (`*.uni`)
  - UEFI Visual Forms Representation (`*.vfr`, `*.hfr`, `*.sd`)
  - ACPI Source Language (`*.asl`, `*.asi`, `*.dsl`)
  - UEFI C extensions (`after/syntax/c.vim` for types, status codes, protocols, `%r`, `%t`)
- **Indentation (`indent/`)**:
  - Automatic C-style indentation (`cindent`) for ASL (`*.asl`) and VFR (`*.vfr`) files.
- **Comment Support (`ftplugin/`)**:
  - Automatically sets `commentstring` for all supported formats (`#` for DEC/DSC/FDF/INF, `//` for UNI, `//` and `/* */` for ASL/VFR). Compatible with native commenting (`gc`).
- **Log Helper**:
  - Press `<F5>` in any `*.log` file to reload from disk and jump to the bottom (`G`).
- **Vim Help Documentation**:
  - Full documentation available via `:help uefi`.

## Installation

### Using Vim packages (`:help packages`)

#### Windows
```batch
mkdir %UserProfile%\vimfiles\pack\plugins\start
git clone https://github.com/aphroteus/vim-uefi.git %UserProfile%\vimfiles\pack\plugins\start\vim-uefi
```

#### Linux / macOS
```bash
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/aphroteus/vim-uefi.git ~/.vim/pack/plugins/start/vim-uefi
```

### Using a plugin manager

With [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'aphroteus/vim-uefi'
```

Generate help tags after installation:
```vim
:helptags ALL
```

## Configuration

All features are enabled with sensible defaults. You can customize them in your `.vimrc` / `_vimrc`:

```vim
" UEFI C syntax mode (default: 'auto')
" 'auto': 3-tier smart detection (0 pollution for plain C, 100% active for BIOS/OEM/3rd-party)
" 1     : Force enable for all C files
" 0     : Completely disable UEFI C extensions
let g:uefi_c_syntax = 'auto'

" Toggle function call highlighting in C files (default: 1)
let g:uefi_highlight_functions = 1

" Toggle operator highlighting in C files (default: 1)
let g:uefi_highlight_operators = 1

" Toggle <F5> log reload in *.log files (default: 1)
let g:uefi_log_f5_reload = 1
```

## License

MIT License. See [LICENSE](LICENSE) for details.
