return {
    "akinsho/toggleterm.nvim",
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup()

        vim.keymap.set("n", "<leader>t", ":ToggleTerm<Cr>")

        vim.lsp.commands["rust-analyzer.runSingle"] = function()
            vim.api.nvim_command(":TermExec cmd=\"cargo run\"")
            vim.lsp.codelens.refresh()
        end
    end
}
