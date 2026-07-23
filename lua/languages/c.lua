-- Imports
local debug = require('modules.debug')

-- Locals
local export = {}
local dbgname = ".gdbinit"
local lsp = "clangd"
local lsp_exec = "clangd"
local lsp_version = "22.1.8"
local language = "c"
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

-- LSP functions

-- Exported functions
export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint

-- Exported locals
export.lsp = lsp
export.lsp_exec = lsp_exec
export.lsp_version = lsp_version
export.language = language

return export
