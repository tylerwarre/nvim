-- Python Provider
if vim.fn.has("win32") == 1 then
	local venv_path = vim.fn.stdpath("data") .. '\\nvim-venv\\'
	vim.g.python3_host_prog = venv_path .. 'Scripts\\python'
	vim.env.PATH = vim.env.PATH .. ';' .. venv_path .. 'Scripts\\'
else
	local venv_path = vim.fn.stdpath("data") .. '/nvim-venv/'
	vim.g.python3_host_prog = venv_path .. 'bin/python'
	vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'bin/'
end

-- Node Provider
if vim.fn.has("win32") == 1 then
	local node_path = vim.fn.stdpath("data") .. '\\nvim-node\\'
	vim.g.node_host_prog = node_path .. "node_modules\\neovim\\bin\\cli.js"
	vim.env.PATH = vim.env.PATH .. ';' .. node_path .. 'node_modules\\.bin\\'
else
	local node_path = vim.fn.stdpath("data") .. '/nvim-node/'
	vim.g.node_host_prog = node_path .. "node_modules/neovim/bin/cli.js"
	vim.env.PATH = vim.env.PATH .. ':' .. node_path .. 'node_modules/.bin/'
end

-- Perl Proviers
vim.g.loaded_perl_provider = 0

-- Ruby Proviers
vim.g.loaded_ruby_provider = 0
