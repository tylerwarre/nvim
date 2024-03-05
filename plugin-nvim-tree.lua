--nvim-tree
require("nvim-tree").setup()
local api = require "nvim-tree.api"
vim.keymap.set("n", '<leader>ft', api.tree.toggle)
vim.g.loaded_netrw          = 1
vim.g.loaded_netrwPlugin    = 1
