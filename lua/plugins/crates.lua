return {
    "saecki/crates.nvim",
    tag = "v0.4.0",
    event = "BufRead Cargo.toml",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local crates = require('crates')

        crates.setup()

        vim.keymap.set("n", "<leader>cu", crates.update_all_crates)
    end,
}
