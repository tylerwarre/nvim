local enabledLsps = {
	"clangd", -- C/C++
	"lua_ls" -- lua
}

local lsp_healthchecks = {}

local function removeLsp(lsp)
	for i, v in ipairs(enabledLsps) do
		if v == lsp then
			table.remove(enabledLsps, i)
			break
		end
	end
end

local function checkLsps()
	for i, v in ipairs(enabledLsps) do
		lsp_healthchecks[v]()
	end
end


lsp_healthchecks.lua_ls = function()
	if vim.fn.executable('lua-language-server') ~= 1 then
		removeLsp("lua_ls")
	end
end

lsp_healthchecks.clangd = function()
	if vim.fn.executable('clangd') ~= 1 then
		removeLsp("clangd")
	end
end


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = ev.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})

checkLsps()
vim.lsp.enable(enabledLsps)
