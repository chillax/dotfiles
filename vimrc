set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Let vundle manage vundle, required
Bundle 'gmarik/vundle'

" Other plugins
Bundle 'scrooloose/nerdtree'
Bundle 'mattn/emmet-vim'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'kchmck/vim-coffee-script'
Bundle 'groenewege/vim-less'

" 256 Colors and a theme
set t_Co=256
colorscheme tomorrow-night
set background=dark

" Syntax highlight
syntax enable
filetype plugin indent on

" Line numbering
set number

" Columns (mark column 80)
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Indentation (4 tabs)
set smartindent
set tabstop=4
set shiftwidth=4
set noexpandtab

" Show trailing whitespace
set list
set listchars=tab:\ \ ,trail:.

" Change leader key
let mapleader = ","
let maplocalleader = ";"

" NerdTREE (toggle with C-n, close vim if only NerdTree open)
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed
