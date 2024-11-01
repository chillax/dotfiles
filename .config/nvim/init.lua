-- vim-plug initialization
local Plug = vim.fn['plug#']
vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------

-- Libraries
Plug 'nvim-lua/plenary.nvim'                -- Required by telescope

-- Languages
Plug 'MaxMEllon/vim-jsx-pretty'             -- JSX/TSX indentation
Plug 'jparise/vim-graphql'                  -- GraphQL
Plug 'mrcjkb/rustaceanvim'                  -- Rust

-- LSP
Plug 'neovim/nvim-lspconfig'                -- Configs for neovim lsp client

-- Completion
Plug 'echasnovski/mini.completion'          -- Completion

-- Formatting
Plug 'stevearc/conform.nvim'                -- Lightweight formatter

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

-- Colorschemes
Plug 'rktjmp/lush.nvim'                     -- Tools for editing colorschemes
Plug 'miikanissi/modus-themes.nvim'
Plug 'zenbones-theme/zenbones.nvim'

-- UI
Plug 'vimpostor/vim-lumen'                  -- Automatic dark/light mode
Plug 'nvim-telescope/telescope.nvim'         -- Fuzzy finder
Plug 'gennaro-tedesco/nvim-peekup'          -- Vim register browser
Plug 'nvim-lualine/lualine.nvim'            -- Fast statusline
Plug 'petertriho/nvim-scrollbar'            -- Scrollbar with some status signs

-- Integrations
Plug 'tpope/vim-fugitive'                   -- Git integration
Plug 'lewis6991/gitsigns.nvim'              -- Git signcolumn integration
Plug 'editorconfig/editorconfig-vim'        -- Editorconfig support
Plug 'tpope/vim-eunuch'                     -- UNIX helpers

-- Misc
Plug 'tpope/vim-vinegar'                    -- Quick netrw navigation
Plug 'tpope/vim-surround'                   -- Surrounds
Plug 'tpope/vim-unimpaired'                 -- Useful [] mappings
Plug 'tpope/vim-sleuth'                     -- Automatic indentation settings
Plug 'tpope/vim-repeat'                     -- Better repeat with .
Plug 'tpope/vim-obsession'                  -- Automatic session management
Plug 'andymass/vim-matchup'                 -- Better matching tag jumping
Plug 'ggandor/leap.nvim'                    -- Fast sneak-style navigation
Plug 'godlygeek/tabular'                    -- Align text easily

vim.call('plug#end')

-------------------------------------------------------------------------------
-- General Settings
-------------------------------------------------------------------------------

-- Leader key configuration
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- File handling
vim.opt.undofile = true              -- Persistent undo
vim.opt.clipboard = "unnamedplus"    -- Use system clipboard
vim.g.netrw_fastbrowse = 0          -- Prevent netrw orphan buffers

-- Search behavior
vim.opt.ignorecase = true           -- Case insensitive search
vim.opt.smartcase = true            -- But case sensitive when uppercase present

-- Input behavior
vim.opt.mouse = "a"                 -- Enable mouse in all modes
vim.opt.completeopt = "menu,menuone,noinsert,popup"

-------------------------------------------------------------------------------
-- Visual Settings
-------------------------------------------------------------------------------

-- Colors and styling
vim.opt.termguicolors = true        -- True color support
vim.opt.cursorline = true           -- Highlight cursor line
vim.cmd('colorscheme zenwritten')    -- Set colorscheme

-- Line numbers
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Show relative line numbers

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  tab = ">·",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "+"
}

-- Window behavior
vim.opt.splitbelow = true           -- Open new splits below
vim.opt.splitright = true           -- Open new splits right
vim.opt.foldmethod = "manual"       -- Manual folding

-------------------------------------------------------------------------------
-- Key Mappings
-------------------------------------------------------------------------------

-- General mappings
local map = vim.keymap.set
local opts = { silent = true }

-- Config editing
map("n", "<Leader>ve", ":split $MYVIMRC<CR>")
map("n", "<Leader>vs", ":source $MYVIMRC<CR>")

-- Telescope mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>b", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>s", "<cmd>Git<cr>")

-- Visual mode movements
map("v", "<S-J>", ":m '>+1<CR>gv", opts)
map("v", "<S-K>", ":m '<-2<CR>gv", opts)

-- Terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>") -- <Esc><Esc> to exit terminal mode

-- Diagnostic keymaps
map('n', '<space>d', vim.diagnostic.open_float)
map('n', '<space>q', vim.diagnostic.setloclist)

-------------------------------------------------------------------------------
-- LSP Configuration
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- LSP attach configuration
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local format = function()
      if client.name == "tsserver" or client.name == "vtsls" then
        require("conform").format({ bufnr = args.buf, timeout_ms = 3000 })
      else
        vim.lsp.buf.format({ timeout_ms = 3000 })
      end
    end

    local opts = { buffer = args.buf }

    -- LSP keymaps
    local lsp_maps = {
      ['<C-k>'] = vim.lsp.buf.signature_help,
      ['<space>D'] = vim.lsp.buf.type_definition,
      ['<space>lf'] = format,
      ['<space>r'] = vim.lsp.buf.rename,
      ['gD'] = vim.lsp.buf.declaration,
      ['ga'] = vim.lsp.buf.code_action,
      ['gd'] = vim.lsp.buf.definition,
      ['gi'] = vim.lsp.buf.implementation,
      ['gr'] = vim.lsp.buf.references,
    }

    for key, func in pairs(lsp_maps) do
      map('n', key, func, opts)
    end
  end
})

-- LSP server configurations
local servers = {
  denols = {
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    settings = {
      deno = {
        enable = true,
        lint = true
      }
    }
  },
  vtsls = {
    root_dir = lspconfig.util.root_pattern("package.json"),
    single_file_support = false
  },
  eslint = {}
}

-- Setup all LSP servers
for server, config in pairs(servers) do
  lspconfig[server].setup(config)
end

-------------------------------------------------------------------------------
-- Plugin Configurations
-------------------------------------------------------------------------------

require('mini.completion').setup()
require("scrollbar").setup()
require("gitsigns").setup()
require("scrollbar.handlers.gitsigns").setup()
require('leap').add_default_mappings()

-- Treesitter context
require('treesitter-context').setup({
  max_lines = 4,
})

-- Lualine status line
require("lualine").setup({
  options = {
    icons_enabled = false,
    section_separators = '',
    component_separators = ''
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{ 'filename', path = 1 }},
    lualine_c = {'diff'},
    lualine_x = {'filetype'},
    lualine_y = {{'diagnostics', sources={'nvim_diagnostic'}}},
  }
})

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "javascript", "typescript", "tsx", "json", "json5", "lua", "vim",
    "vimdoc", "rust", "sql", "php", "c", "zig", "css", "graphql"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- Telescope configuration
require('telescope').setup({
  defaults = {
    preview = {
      treesitter = false,
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
    },
    find_files = {
      previewer = false
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

-- Formatter configuration
local js_ts_formatters = { "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
  formatters_by_ft = {
    javascript = js_ts_formatters,
    javascriptreact = js_ts_formatters,
    typescript = js_ts_formatters,
    typescriptreact = js_ts_formatters,
    graphql = { "prettier" }
  },
})
