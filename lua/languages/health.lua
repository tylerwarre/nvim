local export = {}

local function _check_version(lsp_exec, lsp_version, is_startup)
	local output = vim.system({ lsp_exec, "--version" }, { text = true }):wait()

	if output.code ~= 0 then
		if is_startup == false then
			vim.health.warn("LSP Version: unable to get " .. lsp_exec .. " server version")
		end
		return true
	end

	local version = output.stdout:match("%d+%.%d+%.%d+")
	if version ~= lsp_version then
		if is_startup == false then
			vim.health.warn("LSP Version: certifed for version " .. lsp_version .. " but got " .. version)
		end
	else
		if is_startup == false then
			vim.health.ok("LSP Version: certifed for version " .. lsp_version)
		end
	end

	return true
end

local function _check_exec(lsp_exec, is_startup)
	local ok = true

	if vim.fn.executable(lsp_exec) ~= 1 then
		ok = false
		if is_startup == false then
			vim.health.error("LSP Executable: '" .. lsp_exec .. "' not found in PATH")
		end
	else
		if is_startup == false then
			vim.health.ok("LSP Executable: '" .. lsp_exec .. "' found in PATH")
		end
	end

	return ok
end

local function _check_config(lsp, is_startup)
	local ok = true
	local lsp_config = vim.fn.stdpath("config") .. "/lsp/" .. lsp

	if vim.uv.fs_stat(lsp_config) == false then
		ok = false
		if is_startup == false then
			vim.health.error("LSP Config: No LSP config found for '" .. lsp .. "'")
		end
	else
		if is_startup == false then
			vim.health.ok("LSP Config: LSP config found for '" .. lsp .. "'")
		end
	end

	return ok
end

local function _check_treesitter(language, is_startup)
	local ok = false
	local parsers = vim.api.nvim_get_runtime_file("parser/*.so", true)

	for _, path in ipairs(parsers) do
		if vim.fs.basename(path) == language .. ".so" then
			ok = true
			if is_startup == false then
				vim.health.ok("Treesitter Parser: treesitter parser found for '" .. language .. "'")
			end
			break
		end
	end

	if ok == false then
		if is_startup == false then
			vim.health.error("Treesitter Parser: No treesitter parser found for '" .. language .. "'")
		end
	end

	return ok
end

local function check()
	local languages = require("languages")
	for _, lang in ipairs(languages) do
		-- Skip if language is not defined in module since we don't know the name of
		--	the health report
		if lang.module.language ~= nil then
			vim.health.start(lang.module.language)
			-- Check LSP Config
			if type(lang.module.check_config) == "function" then
				-- Run override function
				lang.module.check_config(false)
			else
				-- Run default function
				_check_config(lang.module.lsp, false)
			end

			-- Check Treesitter Grammer File
			if type(lang.module.check_treesitter) == "function" then
				-- Run override function
				lang.module.check_treesitter(false)
			else
				-- Run default function
				_check_treesitter(lang.module.language, false)
			end

			-- Check LSP Executable
			if type(lang.module.check_exec) == "function" then
				-- Run override function
				if lang.module.check_exec(false) ~= true then
					-- return early since version will fail if exec fails
					return false
				end
			else
				-- Run default function
				if _check_exec(lang.module.lsp_exec, false) ~= true then
					-- return early since version will fail if exec fails
					return false
				end
			end

			-- Check LSP Verison
			if type(lang.module.check_version) == "function" then
				-- Run override function
				lang.module.check_version(false)
			else
				-- Run default function
				_check_version(lang.module.lsp_exec, lang.module.lsp_version, false)
			end
		end
	end
end

local function check_lsp(module)
	local ok = true

	-- Check LSP Config
	if type(module.check_config) == "function" then
		-- Run override function
		if module.check_config(true) ~= true then
			ok = false
		end
	else
		-- Run default function
		if _check_config(module.lsp, true) ~= true then
			ok = false
		end
	end

	-- Check LSP Executable
	if type(module.check_exec) == "function" then
		-- Run override function
		if module.check_exec(true) ~= true then
			-- return early since version will fail if exec fails
			ok = false
		end
	else
		-- Run default function
		if _check_exec(module.lsp_exec, true) ~= true then
			-- return early since version will fail if exec fails
			ok = false
		end
	end

	return ok
end

export.check = check
export.check_lsp = check_lsp
export._check_exec = _check_exec
export._check_version = _check_version
export._check_config = _check_config
export._check_treesitter = _check_treesitter

return export
