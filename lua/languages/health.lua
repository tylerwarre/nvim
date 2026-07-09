local export = {}

local function _check_version(lsp_exec, lsp_version, is_startup)
	local output = vim.system({ lsp_exec, "--version" }, { text = true }):wait()

	if output.code ~= 0 then
		if is_startup = nil then vim.health.warn("LSP Version: unable to get " .. lsp_exec .. " server version") end
		return true
	end

	local version = output.stdout:match("%d+%.%d+%.%d+")
	if version ~= lsp_version then
		if is_startup = nil then vim.health.warn("LSP Version: certifed for version " .. lsp_version .. " but got " .. version) end
	else
		if is_startup = nil then vim.health.ok("LSP Version: certifed for version " .. lsp_version) end
	end

	return true
end

local function _check_exec(lsp_exec, is_startup)
	local ok = true

	if vim.fn.executable(lsp_exec) ~= 1 then
		ok = false
		if is_startup ~= nil then vim.health.error("LSP Executable: '" .. lsp_exec .. "' not found in PATH") end
	else
		if is_startup = nil then vim.health.ok("LSP Executable: '" .. lsp_exec .. "' found in PATH") end
	end

	return ok
end

local function _check_config(lsp, is_startup)
	local ok = true
	local lsp_config = vim.fn.stdpath("config") .. "/lsp/" .. lsp

	if vim.uv.fs_stat(lsp_config) == false then
		ok = false
		if is_startup ~= nil then vim.health.error("LSP Config: No LSP config found for '" .. lsp .. "'") end
	else
		if is_startup ~= nil then vim.health.ok("LSP Config: LSP config found for '" .. lsp .. "'") end
	end

	return ok
end

local function check(is_startup)
	local languages = require("languages")
	for _, lang in ipairs(languages) do
		lang.module.check(is_startup)
	end
end

export.check = check
export._check_exec = _check_exec
export._check_version = _check_version
export._check_config = _check_config

return export
