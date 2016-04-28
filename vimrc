set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mattn/emmet-vim'
Plug 'chriskempson/base16-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/limelight.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" 256 Colors and a theme
set t_Co=256
colorscheme base16-default
set background=dark

" Syntax highlight
syntax enable

" Always show statusline
set laststatus=2

" Hide scrollbars in GUI mode
set guioptions-=r
set guioptions-=L

" Use powerline fonts in GUI mode ('Needs Incosolata for PowerLine' font)
if has("gui_running")
	let g:airline_powerline_fonts = 1
	set guifont=Menlo\ for\ Powerline:h11
endif

" Line numbering
set number

" Columns (mark column 80)
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" Indentation (4 tabs)
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Toggle indentation (4 tabs / 2 spaces)
function TabToggle()
	if &expandtab
		set shiftwidth=4
		set tabstop=4
		set softtabstop=4
		set noexpandtab
	else
		set shiftwidth=2
		set tabstop=2
		set softtabstop=2
		set expandtab
	endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z


" Show trailing whitespace
set list
set listchars=tab:\ \ ,trail:.

" Change leader key
let mapleader = ","
let maplocalleader = ";"

" NerdTREE (toggle with C-n, close vim if only NerdTree open)
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" change ctrlp working directory to nerdtree's root
let g:NERDTreeChDirMode = 2
let g:ctrlp_working_path_mode = 'rw'

" ctrlp ignored folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Rainbow hilite parens
let g:rainbow_active = 1

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed

" Airline tabline
let g:airline#extensions#tabline#enabled = 1

" Airline theme
let g:airline_theme='base16_default'
