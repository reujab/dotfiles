if $NVIM_TUI_ENABLE_CURSOR_SHAPE
	echo "[Warning] You are in a nested vim session."
endif

source ~/.vim/plugged/vim-plug/plug.vim

call plug#begin()

" Plug 'Valloric/YouCompleteMe'
" let ycm_min_num_of_chars_for_completion = 0
" set completeopt-=preview
" set shortmess+=c

Plug 'Shougo/deoplete.nvim'
Plug 'ervandew/supertab'
Plug 'zchee/deoplete-go'
inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
let SuperTabDefaultCompletionType = '<c-n>'
let deoplete#enable_at_startup = 1
set completeopt-=preview

" Plug 'ervandew/supertab'
" Plug 'maralla/completor.vim'
" inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
" let SuperTabDefaultCompletionType = '<c-n>'
" set shortmess+=c

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'digitaltoad/vim-pug'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
Plug 'garbas/vim-snipmate'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-plug'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

call plug#end()

autocmd InsertLeave * pclose!

colorscheme onedark

command! NT call NewTerm()

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

let ale_lint_on_enter = 0
let ale_lint_on_save = 1
let ale_lint_on_text_changed = 0
let ale_linters = {}
let ale_linters.go = {}
let ale_sign_error = '✗'

let go_fmt_command = "goimports"
let go_template_autocreate = 0

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

nmap - gT
nmap <c-l> :mode<cr>
nmap <cr> <plug>NERDCommenterToggle
nmap <leader> <plug>(easymotion-prefix)
nmap <space> :w<cr>
nmap = gt
nmap U :redo<cr>
nmap gp "+p

set cursorline
set ignorecase
set mouse=a
set nohlsearch
set number
set relativenumber
set shiftwidth=2
set smarttab
set tabstop=2
set termguicolors
set title

tmap <esc> <c-\><c-n>

vmap gp "+p
vmap <cr> <plug>NERDCommenterToggle
vmap s :sort<cr>

function! NewTerm()
	tabe term://.//zsh
	tabm 0
	startinsert
endfunction
