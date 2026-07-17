-- Imports
local debug = require('modules.debug')
local health = require('languages.health')

-- Locals
local export = {}
local dbgname = ".gdbinit"
local lsp = "clangd"
local lsp_exec = "clangd"
local lsp_version = "22.1.8"
local language = "cpp"
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

return export
