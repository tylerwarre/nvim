return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
    keys = {
        {"<leader>ff", function() require("telescope.builtin").find_files() end},
        {"<leader>fg", function() require("telescope.builtin").git_files() end},
        {"<leader>fs", function() require("telescope.builtin").grep_string({search = vim.fn.input("Grep > ") }) end},
    },
    opts = {
        extensions = {
            ['ui-select'] = {
                require('telescope.themes').get_dropdown {
                }
            }
        }
    },
    config = function ()
        require('telescope').load_extension('ui-select')
    end,
}
