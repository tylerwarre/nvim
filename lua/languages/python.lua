-- Imports
local health = require('languages.health')
local debug = require('modules.debug')

-- Locals
local export = {}
local dbgname = ".pdbrc"
local lsp = "basedpyright"
local lsp_exec = "basedpyright"
local lsp_version = "1.39.9"
local language = "python"
local venv_path = vim.fn.stdpath("config") .. '/nvim-venv/'
local auto_group = vim.api.nvim_create_augroup(language .. "Breakpoints", { clear = true })

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
	pattern = language,
	group = auto_group,
	callback = function()
		-- Read breakpoints file async
		vim.schedule(function()
			debug.f_read_breakpoints(dbgname)
		end)
	end,
})

-- Debug functions
local function write_breakpoint(lnum)
	debug.f_write_breakpoint(lnum, dbgname)
end

local function delete_breakpoint(lnum)
	debug.f_delete_breakpoint(lnum, dbgname)
end

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

local function check_treesitter(is_startup)
	return health._check_treesitter(language, is_startup)
end

local function check(is_startup)
	local ok = true
	if is_startup == nil then vim.health.start(language) end

	if check_exec(is_startup) ~= true then
		ok = false
	end
	if check_version(is_startup) ~= true then
		ok = false
	end
	if check_config(is_startup) ~= true then
		ok = false
	end
	if check_treesitter(is_startup) ~= true then
		ok = false
	end

	return ok
end

-- Exported functions
export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint
export.check = check

-- Exported locals
export.lsp = lsp

-- Language Settings
if vim.fn.has("win32") == 1 then
	vim.g.python3_host_prog = venv_path .. 'Scripts/python'
	vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'Scripts/'
else
	vim.g.python3_host_prog = venv_path .. 'bin/python'
	vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'bin/'
end

return export
