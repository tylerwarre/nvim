vim.g.mapleader = " "

-- Easier window navigation
vim.keymap.set("n", "<leader>H", "<C-W>h")
vim.keymap.set("n", "<leader>J", "<C-W>j")
vim.keymap.set("n", "<leader>K", "<C-W>k")
vim.keymap.set("n", "<leader>L", "<C-W>l")
vim.keymap.set("n", "<leader>Z", "<C-W>z")

-- Change tabs with leader + vim arrow keys
vim.keymap.set("n", "<leader>h", "gT")
vim.keymap.set("n", "<leader>l", "gt")
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")
vim.keymap.set("n", "<leader>0", "10gt")

-- Jump back to previous file
vim.keymap.set("n", "gr", ":e#<CR>")

-- Don't leave visual mode when indenting l
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
