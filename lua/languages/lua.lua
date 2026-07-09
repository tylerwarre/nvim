-- Imports
local health = require('languages.health')

-- Locals
local export = {}
local lsp = "lua_ls"
local lsp_exec = "lua-language-server"
local lsp_version = "3.18.2"

-- LSP Functions
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
export.check = check

-- Exported locals
export.lsp = lsp

-- Exp

return export
