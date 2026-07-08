-- Locals
local export = {}
local lsp = "lua_ls"

-- LSP Functions
local function lsp_healthcheck()
	if vim.fn.executable('lua-language-server') ~= 1 then
		return false
	end

	return true
end


-- Exported functions
export.lsp_healthcheck = lsp_healthcheck

-- Exported locals
export.lsp = lsp

-- Exp

return export
