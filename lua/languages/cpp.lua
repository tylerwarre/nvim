-- Debug
local debug = require('modules.debug')

-- Locals
local export = {}
local dbgname = ".gdbinit"
local auto_group = vim.api.nvim_create_augroup("CppDebug", { clear = true })

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

-- Instantiate Functions
local function write_breakpoint(lnum)
	debug.f_write_breakpoint(lnum, dbgname)
end

local function delete_breakpoint(lnum)
	debug.f_delete_breakpoint(lnum, dbgname)
end

-- Export functions
export.write_breakpoint = write_breakpoint
export.delete_breakpoint = delete_breakpoint

return export
