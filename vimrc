"
" Requirements:
" - minpac for plugin management
"

set nocompatible

"
" Plugin config
"

" Try to load minpac.
packadd minpac

if exists('*minpac#init')
  " Init minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Visual
  call minpac#add('junegunn/seoul256.vim')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('ap/vim-css-color')
  call minpac#add('junegunn/goyo.vim')

  " File management
  call minpac#add('scrooloose/nerdtree')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('tpope/vim-vinegar')

  " Autocompletion & linting
  call minpac#add('w0rp/ale')
  call minpac#add('lifepillar/vim-mucomplete')

  " Integrations
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('editorconfig/editorconfig-vim')

  " Language specific
  call minpac#add('mattn/emmet-vim')
  call minpac#add('styled-components/vim-styled-components', {'branch': 'main'})
  call minpac#add('elixir-editors/vim-elixir')
  call minpac#add('slashmili/alchemist.vim')

  " Misc
  call minpac#add('tpope/vim-surround')
  call minpac#add('andymass/vim-matchup')
  call minpac#add('cohama/lexima.vim')
  call minpac#add('tomtom/tcomment_vim')

  " Plugin specific config

  " Colorscheme
  let g:seoul256_background=233
  colo seoul256

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

  " Faster update for signify
  set updatetime=400

  " Add fzf to runtime path
  set rtp+=/usr/local/opt/fzf

  " Map fzf to ctrl+p
  nnoremap <silent> <C-p> :FZF -m<cr>

  " NERDTree (toggle with C-n, close vim if only NerdTree open)
  let NERDTreeShowLineNumbers=0
  map <C-n> :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  " Fix syntax highlighting in .vue files
  autocmd FileType vue syntax sync fromstart
  let g:vue_disable_pre_processors=1

  " ALE Config

  let g:ale_completion_enabled = 1

  let g:ale_linters_explicit = 1
  let g:ale_linters = {
  \  'javascript': ['eslint']
  \}

  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['prettier', 'eslint'],
  \}

  set omnifunc=ale#completion#OmniFunc
endif

"
" General config
"

" Colors
set t_Co=256
set background=dark

" To map <Esc> to exit terminal-mode:
:tnoremap <Esc> <C-\><C-n>

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

" Remaps
nnoremap <Leader>h :bp<CR>
nnoremap <Leader>l :bn<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d :ALEDetail<CR>
nnoremap <Leader>i :normal migg=G`i`<CR>

" Mouse support
set mouse=a

" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" OSX clipboard
set clipboard=unnamed

" Completion
set completeopt+=menuone,noinsert,noselect
set shortmess+=c   " Supress completion messages
set belloff+=ctrlg " Silence Vim beeps during completion
