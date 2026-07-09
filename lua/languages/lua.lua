-- Imports
local health = require('languages.health')

-- Locals
local export = {}
local lsp = "lua_ls"
local lsp_exec = "lua-language-server"
local lsp_version = "3.18.2"

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
	if is_startup == nil then vim.health.start("Lua") end

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

return export
