vim.opt.number      = true
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = false
vim.opt.autoindent  = true
vim.opt.mouse       = ""
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Define LSP Diagnostic Symbols
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN]  = '',
			[vim.diagnostic.severity.INFO]  = '',
			[vim.diagnostic.severity.HINT]  = ''
		}
	}
})
