return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            config = true,
        },
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                '${3rd}/luv/library',
                                unpack(vim.api.nvim_get_runtime_file('', true)),
                            },
                        },
                        completion = {
                            callSnippet = 'Replace',
                        },
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all",
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
            gopls = {
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
                },
            },
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            if client.server_capabilities.codeLensProvider then
                vim.lsp.codelens.refresh()

                vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
                    buffer = bufnr,
                    callback = vim.lsp.codelens.refresh,
                })
            end

            local telescope = require('telescope.builtin')
            vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
            vim.keymap.set("n", "gr", telescope.lsp_references, opts)

            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end
        end

        require('mason').setup()
        local ensure_installed = vim.tbl_keys(servers)
        require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name]
                    server.on_attach = on_attach
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }

        local cmp = require('cmp')
        local config = cmp.get_config()
        table.insert(config.sources, { name = "nvim_lsp" })
        cmp.setup(config)
    end
}