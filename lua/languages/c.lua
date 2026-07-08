-- Imports
local debug = require('modules.debug')

-- Locals
local export = {}
local dbgname = ".gdbinit"
local lsp = "clangd"
local auto_group = vim.api.nvim_create_augroup("CBreakpoints", { clear = true })

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
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

-- LSP functions
local function lsp_healthcheck()
	if vim.fn.executable('clangd') ~= 1 then
		return false
	end

	return true
end

-- Exported functions
export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint
export.lsp_healthcheck = lsp_healthcheck

-- Exported locals
export.lsp = lsp

return export
