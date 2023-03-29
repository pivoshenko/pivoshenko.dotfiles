" plugins
call plug#begin('~/.vim/plugged')
Plug 'frazrepo/vim-rainbow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

" syntax highlighting
syntax on
filetype plugin on
set encoding=utf-8

set termguicolors

" theme configuration
colorscheme onedark
" load statusbar
autocmd vimenter * ++nested colorscheme onedark
" use true colors
set termguicolors
" display the status line
set laststatus=2
" highlight line
set cursorline
" highlight breakline
set colorcolumn=100
" display indents
set list listchars=tab:»-,trail:·,extends:»,precedes:«

" hybrid line numbers
set number relativenumber
set nu rnu

" general configuration
set mouse=a
set noswapfile
set nocompatible
set clipboard=unnamed

" indents configuration
set tabstop=4
set autoindent
set backspace=indent,eol,start

" NERD tree configuration
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" status bar configuration
let g:airline_powerline_fonts=1
let g:airline_theme='onedark'
