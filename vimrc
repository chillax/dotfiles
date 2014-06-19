set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#begin()

" Let vundle manage vundle, required
Plugin 'gmarik/vundle'

" Other plugins
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline'

call vundle#end()

" 256 Colors and a theme
set t_Co=256
colorscheme Tomorrow-Night
set background=dark

" Syntax highlight
syntax enable
filetype plugin indent on

" Always show statusline
set laststatus=2

" Use powerline fonts in GUI mode ('Needs Incosolata for PowerLine' font)
if has("gui_running")
	let g:airline_powerline_fonts = 1
	set guifont=Inconsolata\ for\ Powerline:h13
endif

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

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed
