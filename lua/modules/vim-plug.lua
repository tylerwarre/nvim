local vim = vim

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('ellisonleao/gruvbox.nvim')
Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('nvim-treesitter/playground')
Plug('nvim-lua/plenary.nvim')
-- Telescope
Plug('nvim-telescope/telescope.nvim', {['tag'] = '0.1.5' })
Plug('nvim-telescope/telescope-ui-select.nvim')
-- LSP
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('VonHeikemen/lsp-zero.nvim', {['branch'] = 'v3.x'})
-- DAP
Plug('mfussenegger/nvim-dap')
vim.call('plug#end')
