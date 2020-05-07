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
  call minpac#add('arzg/vim-colors-xcode')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('ap/vim-css-color')
  call minpac#add('junegunn/goyo.vim')

  " File management
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
  call minpac#add('maxmellon/vim-jsx-pretty')
  call minpac#add('jonsmithers/vim-html-template-literals')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('posva/vim-vue')
  call minpac#add('cakebaker/scss-syntax.vim')
  call minpac#add('jparise/vim-graphql')

  " Misc
  call minpac#add('tpope/vim-surround')
  call minpac#add('andymass/vim-matchup')
  call minpac#add('tomtom/tcomment_vim')

  " Plugin specific config

  " Colorscheme
  colorscheme xcodedark

  " Statusline
  set laststatus=2
  let g:lightline = {
        \ 'colorscheme': 'one',
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
  \   'javascript': ['eslint'],
  \}

  set omnifunc=ale#completion#OmniFunc

  " Decrease amount of preprocessor checks for vue files
  let g:vue_pre_processors = ['scss']

  " Signify colors
  highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
  highlight SignifySignAdd    ctermfg=green  guifg=#acf2e4 cterm=NONE gui=NONE
  highlight SignifySignDelete ctermfg=red    guifg=#ff8170 cterm=NONE gui=NONE
  highlight SignifySignChange ctermfg=yellow guifg=#d9c97c cterm=NONE gui=NONE
endif

"
" General config
"

" Show 
set showcmd

" Colors
set t_Co=256
set background=dark
set termguicolors

" Override background color with transparent
augroup vimrc
 autocmd!
 autocmd ColorScheme * hi Normal guibg=NONE
 autocmd ColorScheme * hi NonText guibg=NONE
 autocmd ColorScheme * hi EndOfBuffer guibg=NONE
augroup END

" To map 2x <Esc> to exit terminal-mode:
:tnoremap <Esc><Esc> <C-\><C-n>

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
set autoindent
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" Hide scrollbars in GUI mode
set guioptions-=r
set guioptions-=L

" Columns (mark column 80)
set colorcolumn=80
highlight ColorColumn ctermbg=234 guibg=#1d1d21

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

" Show tab completion bar when needed
set wildmenu

" File name completion with tab in command mode
set wildmode=list:longest,full

" OSX clipboard
set clipboard=unnamed

" Completion
set completeopt+=menuone,noinsert,noselect
set shortmess+=c   " Supress completion messages
set belloff+=ctrlg " Silence Vim beeps during completion

" Markdown code blocks
let g:markdown_fenced_languages = ['html', 'js=javascript', 'bash=sh', 'sql']

" Prevent netrw from leaving orphan buffers
let g:netrw_fastbrowse = 0

" Decrease esc delay
set ttimeout " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Better html indenting of <style> tags, see :help html-indenting
let g:html_indent_style1 = "inc"
