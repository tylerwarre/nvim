return {
    { "williamboman/mason.nvim", opts = {}, cmd = {"Mason"}},
    { "williamboman/mason-lspconfig.nvim", lazy = false, opts = { ensure_installed = {"lua_ls", "gopls" } }},
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        -- example using `opts` for defining servers
        opts = {
            servers = {},
            automatic_installation = true,
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig['lua_ls'].setup({ capabilities = capabilities })
            lspconfig['gopls'].setup({ capabilities = capabilities })
        end
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = 'rafamadriz/friendly-snippets',
        event = {"BufRead"},
        keys = {
            {"gd", function() vim.lsp.buf.definition() end, mode = {"n"}},
            {"<leader>vd", function() vim.lsp.buf.hover() end, mode = {"n"}},
            {"<leader>vs", function() vim.lsp.buf.workspace_symbol() end, mode = {"n"}},
            {"<leader>ve", function() vim.diagnostic.open_float() end, mode = {"n"}},
            {"[d", function() vim.diagnostic.goto_next() end, mode = {"n"}},
            {"]d", function() vim.diagnostic.goto_prev() end, mode = {"n"}},
            {"gR", function() require('telescope.builtin').lsp_references() end, mode = {"n"}},
            {"<leader>va", function() vim.lsp.buf.code_action() end, mode = {"n"}},
            {"<leader>vr", function() vim.lsp.buf.rename() end, mode = {"n"}},
            {"<C-h>", function() vim.lsp.buf.signature_help() end, mode = {"i"}},
        },

        -- use a release tag to download pre-built binaries
        version = '*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'default', ['<C-space>'] = {function(cmp) cmp.show() end}},

            signature = {
                enabled = true,
                window = {
                    border = 'rounded',
                },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                cmdline = {},
            },
            completion = {
                documentation =  {
                    window = {
                        border = "rounded",
                    }
                },
                menu = {
                    border = "rounded",
                },
                ghost_text = {
                    enabled = true,
                },
            }
        },
        opts_extend = { "sources.default" },
    }
}
