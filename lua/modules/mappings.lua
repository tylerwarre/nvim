vim.g.mapleader = " "

-- Telescope
local status, telescope = pcall(function()
	return require('telescope.builtin')
end)

if status then
	vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope: find files' })
	vim.keymap.set('n', '<leader>fg', telescope.git_files, { desc = 'Telescope: find files' })
	vim.keymap.set('n', '<leader>fs', telescope.live_grep, { desc = 'Telescope: search files' })
end

-- Debug
vim.keymap.set('n', '<leader>db', function() vim.cmd("Break") end, { desc = 'Debug: toggle breakpoint on current line' })

-- Checkbox
vim.keymap.set('n', '<leader>cc', "<cmd>normal! 0t]rx<CR>")
vim.keymap.set('n', '<leader>cu', "<cmd>normal! 0t]r<Space><CR>")

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
