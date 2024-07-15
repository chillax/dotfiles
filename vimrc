"
" Requirements:
" - minpac for plugin management
"

set nocompatible

"
" Plugin config
"

" Try to load minpac.
set packpath^=~/.vim
packadd minpac

if exists('g:loaded_minpac')
  " Init minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Languages
  call minpac#add('philj56/vim-rgbasm')

  " LSP
  call minpac#add('yegappan/lsp')

  " Completion
  call minpac#add('lifepillar/vim-mucomplete')

  " File management
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('tpope/vim-vinegar')

  " Integrations
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('mhinz/vim-signify')
  call minpac#add('editorconfig/editorconfig-vim')

  " Misc
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-eunuch')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('andymass/vim-matchup')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('justinmk/vim-sneak')
endif

" Colorscheme
colorscheme wildcharm

" Statusline
set laststatus=2

" Show offscreen matching paren in popup
let g:matchup_matchparen_offscreen = {'method': 'popup'}

" Faster update for signify
set updatetime=400

" XCodeish signify settings
let g:signify_sign_add    = '┃'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '•'
let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines.

" Add fzf to runtime path
set rtp+=/usr/local/opt/fzf

" FZF
let g:fzf_layout = { 'down': '40%' }

if has("gui_running")
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif

" Fix syntax highlighting in .vue files
autocmd FileType vue syntax sync fromstart

"
" General config
"

" Automatically reload changed file
set autoread

" Line numbering
set relativenumber
set ruler

" Show
set showcmd

" Set swapfile folder to ~/.vim/swapfiles
set directory=$HOME/.vim/swapfiles//

set backup
set backupdir=$HOME/.vim/backup//

set undofile
set undodir=$HOME/.vim/undo//

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif

set sessionoptions-=options
set viewoptions-=options

" Allow changing buffers with unsaved changes
set hidden

" Always display atleast one line line above/below cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Search improvements
set incsearch " show search matches as you type

" Highlight search results only when searching
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Default indentation & syntax
filetype plugin on
filetype plugin indent on
syntax enable
set backspace=indent,eol,start
set autoindent
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" Show trailing whitespace
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Change leader key
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" Remaps
nnoremap <silent> <Leader>ff :FZF -m<cr>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>i :normal migg=G`i`<CR>
nnoremap <Leader>ve :vsplit $MYVIMRC<cr>
nnoremap <Leader>vs :source $MYVIMRC<cr>
" To map 2x <Esc> to exit terminal-mode:
tnoremap <Esc><Esc> <C-\><C-n>

" Mouse support
set mouse=a

" Show tab completion bar when needed
set wildmenu

" File name completion with tab in command mode
set wildmode=list:longest,full

" OSX clipboard
set clipboard=unnamed

" Completion
set completeopt+=longest,menuone,noinsert,noselect,preview,popup
set shortmess+=c   " Supress completion messages
set belloff+=ctrlg " Silence Vim beeps during completion

" Markdown code blocks
let g:markdown_fenced_languages = ['html', 'js=javascript', 'bash=sh', 'sql']

" Prevent netrw from leaving orphan buffers
let g:netrw_fastbrowse = 0

" Decrease esc delay
set ttimeout " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Don't consider octals (e.g. 007) numbers for inc/dec
set nrformats-=octal

" Better html indenting of <style> tags, see :help html-indenting
let g:html_indent_style1 = 'inc'

" Use utf-8 encoding
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" Delete comment character when joining commented lines
set formatoptions+=j

" Change the direction of new splits
set splitbelow
set splitright

" MacVim stuff
if has("gui_macvim")
  " set guifont=SF\ Mono\ Regular:h13
  set guifont=-monospace-:h13
endif

" LSP config
let tslsp = [#{
      \    name: 'typescriptlang',
      \    filetype: ['typescript', 'typescriptreact'],
      \    path: '/Users/joonas/.asdf/shims/typescript-language-server',
      \    args: ['--stdio'],
      \    rootSearch: ['package.json'],
      \    runUnlessSearch: ['deno.json'],
      \  }]

let denolsp = [#{
      \    name: 'deno',
      \    filetype: ['typescript', 'typescriptreact'],
      \    path: '/Users/joonas/.asdf/shims/deno',
      \    args: ['lsp'],
      \    debug: v:true,
      \    initializationOptions: #{
      \       enable: v:true,
      \       lint: v:true
      \    },
      \    rootSearch: ['deno.json'],
      \    runIfSearch: ['deno.json'],
      \  }]

if executable('typescript-language-server')
  autocmd VimEnter * call LspAddServer(tslsp)
endif

if executable('deno')
  autocmd VimEnter * call LspAddServer(denolsp)
endif

def SetupLspKeys()
  nnoremap <silent> K :LspHover<cr>
  nnoremap <silent> [d :LspDiagPrev<cr>
  nnoremap <silent> ]d :LspDiagNext<cr>
  nnoremap <silent> gd :LspGotoDefinition<cr>
  nnoremap <silent> gr :LspShowReferences<cr>
  nnoremap <silent> <leader>d :LspDiagShow<cr>
  nnoremap <silent> <leader>r :LspRename<cr>
enddef

autocmd User LspAttached call SetupLspKeys()
