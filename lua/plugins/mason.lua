return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_dap = require("mason-nvim-dap")

        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "hls",
                "clangd",
            },
        })
        mason_dap.setup({
            ensure_installed = {
                "codelldb",
            },
        })
    end,
}
