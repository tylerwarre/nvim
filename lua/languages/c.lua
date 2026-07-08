-- Debug
local debug = require('modules.debug')

-- Locals
local export = {}
local dbgname = ".gdbinit"

-- Autocommands
local auto_group = vim.api.nvim_create_augroup("CDebug", { clear = true })

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

local function write_breakpoint(lnum)
	debug.f_write_breakpoint(lnum, dbgname)
end

local function delete_breakpoint(lnum)
	debug.f_delete_breakpoint(lnum, dbgname)
end

export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint

return export
