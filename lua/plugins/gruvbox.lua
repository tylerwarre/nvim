return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            terminal_colors = true,
            italic = {
                strings = false,
                emphasis = true,
                commnets = true,
                operators = false,
                folds = true,
            }
        },
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme gruvbox]])
            vim.cmd([[highlight Normal ctermbg=NONE guibg=NONE]])
        end,
    },
}
