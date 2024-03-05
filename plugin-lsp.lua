local lsp_zero = require('lsp-zero')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
print("test")

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true}),
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})

---@diagnostic disable-next-line: unused-local
lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ve", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gR", function() require('telescope.builtin').lsp_references() end, { noremap = true, silent = true } )
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require("mason").setup()
require("mason-lspconfig").setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' }}
                    }
                }
            })
        end,
    },
})

vim.diagnostic.config({
    virtual_text = true
})
