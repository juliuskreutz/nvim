return {
    "neovim/nvim-lspconfig",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities()
        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            vim.lsp.codelens.refresh()

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format()
                end,
            })

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint(bufnr, true)
            end
        end

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                }
            }
        })

        lspconfig.hls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                haskell = {
                    formattingProvider = "fourmolu",
                    plugin = {
                        rename = {
                            config = {
                                crossModule = true,
                            },
                        },
                    },
                },
            },
        })
    end
}
