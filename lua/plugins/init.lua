vim.api.nvim_create_autocmd('PackChanged', {
	desc = 'telescope: build extensions and setup it up in order',
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			if vim.fn.has("win32") == 1 then
				vim.system(
					{ 'powershell.exe', '-Command', 'cmake -B build; cmake --build build; cp build/Debug/* build/' },
					{ cwd = ev.data.path })
			else
				vim.system({ 'make' }, { cwd = ev.data.path })
			end
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim",                     version = "2.0.0" },
	{ src = "https://github.com/stevearc/oil.nvim.git",                        version = "v2.16.0" },
	{ src = "https://github.com/tpope/vim-fugitive.git",                       version = "v3.7" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim.git",                version = "221ce6b2d999187044529f49da6554a92f740a96" },
	-- Telescope Dependancies Start
	{ src = "https://github.com/nvim-lua/plenary.nvim.git",                    version = "74b06c6c75e4eeb3108ec01852001636d85a932b" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git", version = "b25b749b9db64d375d782094e2b9dce53ad53a40" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git",  version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2" },
	-- Telescope Dependancies End
	{ src = "https://github.com/nvim-telescope/telescope.nvim.git",            version = "v0.2.2" },
})

require("plugins.gruvbox")
require("plugins.lualine")
require("plugins.oil")
require("plugins.telescope")
