syntax on
set nu
set background=dark
set tabstop=2
set shiftwidth=2
set softtabstop=2
set encoding=utf-8
set t_Co=256
set wildmode=longest,list,full
set wildmenu
set ignorecase
set hlsearch
set autoindent
set smartindent
colorscheme jellybeans
set nocompatible
set laststatus=2
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'yko/mojo.vim'
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-expand-region'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'

call vundle#end()
filetype off
filetype plugin indent on " required!

" start nerdtree at vim opening
autocmd vimenter * NERDTree

" vim starts with cursor in file opened.
autocmd vimenter * wincmd p
autocmd vimenter * if !argc() | NERDTree | endif

" close nerdtree when it is the last open buffer.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"" show hidden files in nerdtree
let NERDTreeShowHidden=1

let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

let g:syntastic_html_tidy_exec = 'tidy5'

" Keymaps
let mapleader = "\<space>"
nmap <silent> <Leader>l :NERDTreeToggle<CR>
nmap <Leader>o :CtrlP<CR>
nmap <Leader>w :w<CR>
nmap <Leader>wq :wq<CR>
nmap <Leader>q :q!<CR>

"Select line with space
nmap <Leader><Leader> V
"If visual mode move down a line with space.
vmap <Leader> j

" use v to expand selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" tabs
" map <Leader><Left>  :tabprevious<CR>
" map <Leader><Right> :tabnext<CR>

" needed for vim-gitgutter
hi clear SignColumn

au Filetype perl nmap <C-k> :%!perltidy<CR>
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\(\t\|\s\)\+$/

"remove 1 second delay after exiting insert mode.
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

" I sometimes forget to sudo.
cmap w!! w !sudo tee > /dev/null %

" Turn on folding for perl
"set foldmethod=syntax
"set foldlevelstart=1
"let perl_fold=1

autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
