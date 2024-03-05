return {
    "stevearc/conform.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                markdown = { "prettier" },
                sh = { "beautysh" },
                zsh = { "beautysh" },
                python = { "black" },
            },
            format_on_save = {
                lsp_fallback = true,
            },
        })
    end,
}
