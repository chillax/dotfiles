set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File browser
Plug 'mattn/emmet-vim'            " Html completion
Plug 'bling/vim-airline'          " Status and tab bar
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'         " Git integrations
Plug 'airblade/vim-gitgutter'     " Git status in sidebar
Plug 'sheerun/vim-polyglot'       " Language packs
Plug 'mileszs/ack.vim'            " Ack and ag support
Plug 'scrooloose/nerdcommenter'   " Faster commenting
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'           " Fuzzy file finding
Plug 'junegunn/seoul256.vim'      " Seoul colors <3
Plug 'w0rp/ale'                   " Async linting engine
Plug 'ap/vim-css-color'           " Highlight colors
Plug 'lifepillar/vim-mucomplete'  " Autocompletion
Plug 'tpope/vim-surround'         " Faster surrounding for codes
Plug 'jiangmiao/auto-pairs'       " Autocomplete brackets, parens etc.

call plug#end()

" 256 Colors and a theme
set t_Co=256
let g:seoul256_background = 233
colo seoul256
set background=dark

" Indentation & syntax
filetype plugin indent on
syntax enable
set backspace=indent,eol,start
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent

" Hide scrollbars in GUI mode
set guioptions-=r
set guioptions-=L

" Relative line numbering, show absolute numbers in insert mode
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Map fzf to ctrl+p
nnoremap <silent> <C-p> :FZF -m<cr>

" Use ripgrep in fzf <3
let $FZF_DEFAULT_COMMAND='rg --files --color --hidden --follow --glob "!.git/*"'

" Columns (mark column 80)
set colorcolumn=80
highlight ColorColumn ctermbg=234

" Use ripgrep with ack if available
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" Show trailing whitespace
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Change leader key
let mapleader = ","
let maplocalleader = ";"

nnoremap <Leader>h :bp<CR>
nnoremap <Leader>l :bn<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d :ALEDetail<CR>

" NerdTREE (toggle with C-n, close vim if only NerdTree open)
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed

" Airline tabline
let g:airline#extensions#tabline#enabled = 1

" Airline theme
let g:airline_theme='minimalist'

" Completion with mucomplete
set completeopt+=menuone,noinsert,noselect
set shortmess+=c

let g:mucomplete#enable_auto_at_startup = 1
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

" NERDCommenter - Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" NERDCommenter - Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" NERDCommenter - Align line-wise comment delimiters flush left instead
" of following code indentation
let g:NERDDefaultAlign = 'left'

" NERDCommenter - Allow commenting and inverting empty lines
" (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Fix syntax highlighting in .vue files
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" NERDCommenter hooks for .vue files
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
