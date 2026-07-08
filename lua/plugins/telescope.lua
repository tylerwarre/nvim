require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		fzf = {
			fuzzy = true,          -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
}

local function checkhealth_fzf()
	local load = false
	local lib = vim.fn.stdpath('data') .. "/site/pack/core/opt/telescope-fzf-native.nvim/build/libfzf"

	if vim.fn.has("win32") == 1 then
		if vim.uv.fs_stat(lib .. ".dll") then
			load = true
		end
	else
		if vim.uv.fs_stat(lib .. ".so") then
			load = true
		end
	end

	if load then
		require('telescope').load_extension('fzf')
	end
end

-- Load telescope plugins
pcall(function()
	require('telescope').load_extension('fzf')
end)

pcall(function()
	require('telescope').load_extension('ui-select')
end)
