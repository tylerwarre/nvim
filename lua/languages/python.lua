-- Imports
local health = require('languages.health')

-- Locals
local export = {}
local lsp = "basedpyright"
local lsp_exec = "basedpyright"
local lsp_version = "1.39.9"
local venv_path = '/home/tyler/.config/nvim/nvim-venv/'

-- LSP Functions
local function check_exec(is_startup)
	return health._check_exec(lsp_exec, is_startup)
end

local function check_version(is_startup)
	return health._check_version(lsp_exec, lsp_version, is_startup)
end

local function check_config(is_startup)
	return health._check_config(lsp, is_startup)
end

local function check(is_startup)
	local ok = true
	if is_startup == nil then vim.health.start("python") end

	if check_exec(is_startup) ~= true then
		ok = false
	end
	if check_version(is_startup) ~= true then
		ok = false
	end
	if check_config(is_startup) ~= true then
		ok = false
	end

	return ok
end

-- Exported functions
export.check = check

-- Exported locals
export.lsp = lsp

-- Language Settings
vim.g.python3_host_prog = venv_path .. 'bin/python'
vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'bin/'

return export
