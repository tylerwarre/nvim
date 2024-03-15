local dap = require("dap")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dbc", function()
    dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dc", function()
    if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs("./launch.json", {})
    end
    dap.continue()
end)
vim.keymap.set("n", "<F5>", function()
    if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs("./launch.json", {})
    end
    dap.continue()
end)
vim.keymap.set("n", "<leader>dx", dap.terminate)
vim.keymap.set("n", "S-<F5>", dap.terminate)
vim.keymap.set("n", "<leader>ds", dap.step_into)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<leader>dn", dap.step_over)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<leader>df", dap.step_out)
vim.keymap.set("n", "S-<F11>", dap.step_out)