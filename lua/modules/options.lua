vim.opt.number      = true
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = false
vim.opt.autoindent  = true
vim.opt.signcolumn  = "yes"
vim.opt.mouse       = ""
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Disable greyout of unused variables/functions
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {})
-- Define LSP Diagnostic Symbols
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '●',
			[vim.diagnostic.severity.WARN]  = '●',
			[vim.diagnostic.severity.INFO]  = '●',
			[vim.diagnostic.severity.HINT]  = '●'
		}
	}
})
