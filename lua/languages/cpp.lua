-- Imports
local debug = require('modules.debug')
local health = require('languages.health')

-- Locals
local export = {}
local dbgname = ".gdbinit"
local lsp = "clangd"
local lsp_exec = "clangd"
local lsp_version = "22.1.6"
local auto_group = vim.api.nvim_create_augroup("CppBreakpoints", { clear = true })

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	group = auto_group,
	callback = function()
		-- Read breakpoints file async
		vim.schedule(function()
			debug.f_read_breakpoints(dbgname)
		end)
	end,
})

-- Debug Functions
local function write_breakpoint(lnum)
	debug.f_write_breakpoint(lnum, dbgname)
end

local function delete_breakpoint(lnum)
	debug.f_delete_breakpoint(lnum, dbgname)
end

-- LSP functions
local function check_exec()
	health._check_exec(lsp_exec)
end

local function check_version()
	health._check_version(lsp_exec, lsp_version)
end

local function check_config()
	health._check_config(lsp)
end

local function check()
	local ok = true
	vim.health.start("Cpp")

	if check_exec() ~= true then
		ok = false
	end
	if check_version() ~= true then
		ok = false
	end
	if check_config() ~= true then
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

return export
