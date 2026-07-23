-- Imports
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

-- Exported functions
export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint

-- Exported locals
export.lsp = lsp
export.lsp_exec = lsp_exec
export.lsp_version = lsp_version
export.language = language

-- Language Settings
if vim.fn.has("win32") == 1 then
	vim.g.python3_host_prog = venv_path .. 'Scripts/python'
	vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'Scripts/'
else
	vim.g.python3_host_prog = venv_path .. 'bin/python'
	vim.env.PATH = vim.env.PATH .. ':' .. venv_path .. 'bin/'
end

return export
