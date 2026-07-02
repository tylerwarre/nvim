vim.g.mapleader = " "

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope: find files' })
vim.keymap.set('n', '<leader>fs', telescope.live_grep, { desc = 'Telescope: search files' })
