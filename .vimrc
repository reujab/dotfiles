set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'easymotion/vim-easymotion'
Plugin 'garbas/vim-snipmate'
Plugin 'itchyny/lightline.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'joshdick/onedark.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic'

call vundle#end()

autocmd ColorScheme * highlight ExtraWhitespace guibg=#e06c75

colorscheme onedark

command! NT call NewTerm()

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

let lightline = {}
let lightline.colorscheme = 'onedark'
let lightline.component = {}
let lightline.component.readonly = '%{&readonly?"":""}'
let lightline.separator = {}
let lightline.separator.left = ''
let lightline.separator.right = ''
let lightline.subseparator = {}
let lightline.subseparator.left = ''
let lightline.subseparator.right = ''

let NERDSpaceDelims = 1

let syntastic_check_on_open = 1
let syntastic_check_on_wq = 0
let syntastic_error_symbol = '✗'
let syntastic_javascript_checkers = ['eslint']
let syntastic_warning_symbol = '✗'

let ycm_autoclose_preview_window_after_insertion = 1

nmap - gT
nmap <c-l> :mode<cr>
nmap <cr> <plug>NERDCommenterToggle
nmap <leader> <plug>(easymotion-prefix)
nmap <space> :w<cr>
nmap = gt
nmap U :redo<cr>

set cursorline
set expandtab
set ignorecase
set nohlsearch
set number
set relativenumber
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set termguicolors
set title

tmap <esc> <c-\><c-n>

vmap <cr> <plug>NERDCommenterToggle
vmap s :sort<cr>

function! NewTerm()
  tabe term://.//zsh
  tabm 0
  startinsert
endfunction
