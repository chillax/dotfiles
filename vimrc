set nocompatible

call plug#begin('~/.vim/plugged')

" Visual
Plug 'junegunn/seoul256.vim'      " Seoul colors <3
Plug 'itchyny/lightline.vim'      " Statusline
Plug 'ap/vim-css-color'           " Highlight colors
Plug 'junegunn/goyo.vim'          " Distraction free mode

" File management
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " File browser
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'           " Fuzzy file finding
Plug 'tpope/vim-vinegar'          " Netrw improvements

" Autocompletion & checking
Plug 'w0rp/ale'                   " Async linting engine
Plug 'lifepillar/vim-mucomplete'  " Autocompletion

" Integrations
Plug 'tpope/vim-fugitive'         " Git integrations
Plug 'airblade/vim-gitgutter'     " Git status in sidebar
Plug 'editorconfig/editorconfig-vim' " .editorconfig support

" Language specific
Plug 'mattn/emmet-vim'            " Html completion
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " CSS-in-JS support

" Misc
Plug 'tpope/vim-surround'         " Faster surrounding for codes
Plug 'andymass/vim-matchup'       " Better % tag navigation for html etc.
Plug 'cohama/lexima.vim'          " Less quirky paren matching
Plug 'tomtom/tcomment_vim'        " Operator based commenting

call plug#end()

" 256 Colors and a theme
set t_Co=256
let g:seoul256_background=233
colo seoul256
set background=dark

" Statusline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Set swapfile folder to ~/.vim/swapfiles
set directory=$HOME/.vim/swapfiles//

set backup
set backupdir=$HOME/.vim/backup//

set undofile
set undodir=$HOME/.vim/undo//

" Allow changing buffers with unsaved changes
set hidden

" Search improvements
set hlsearch  " highlight search terms
set incsearch " show search matches as you type

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

" Add fzf to runtime path
set rtp+=/usr/local/opt/fzf

" Map fzf to ctrl+p
nnoremap <silent> <C-p> :FZF -m<cr>

" Use ripgrep in fzf <3
" let $FZF_DEFAULT_COMMAND='rg --files --color --hidden --follow --glob "!.git/*"'

" Columns (mark column 80)
set colorcolumn=80
highlight ColorColumn ctermbg=234

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
nnoremap <Leader>i :normal migg=G`i`<CR>

" NERDTree (toggle with C-n, close vim if only NerdTree open)
let NERDTreeShowLineNumbers=0
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed

" Completion with mucomplete
set completeopt+=menuone,noinsert,noselect
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

let g:mucomplete#enable_auto_at_startup = 1

" Fix syntax highlighting in .vue files
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1

" Let ALE only use Linters specified here
let g:ale_linters_explicit = 1
let g:ale_linters = {
\  'javascript': ['eslint']
\}

" ALE Fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\}
