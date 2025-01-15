return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead" },
        opts = {
            autoinstall = true,
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
}
