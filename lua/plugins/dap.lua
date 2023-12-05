return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        local dap = require("dap")

        local mason_registry = require("mason-registry")
        local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
        local codelldb_path = codelldb_root .. "adapter/codelldb"
        local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
        dap.adapters.rust = {
            type = "server",
            port = "${port}",
            host = "127.0.0.1",
            executable = {
                command = codelldb_path,
                args = { "--liblldb", liblldb_path, "--port", "${port}" },
            },
        }

        dap.configurations.rust = {
            {
                name = "Rust tools debug",
                type = "rust",
                request = "launch",
                program = function()
                    return vim.fn.getcwd() .. "/target/debug/${workspaceFolderBasename}"
                end,
                cwd = vim.fn.getcwd(),
                stopOnEntry = false,
            },
        }

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>ds", dap.step_over)


        local dapui = require("dapui")
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.keymap.set("n", "<leader>dt", dapui.toggle)
    end
}
