return {
	"saecki/crates.nvim",
	event = "BufRead Cargo.toml",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local crates = require("crates")

		crates.setup({
			lsp = {
				enabled = true,
				on_attach = function()
					vim.keymap.set("n", "<leader>cu", crates.update_all_crates, { silent = true })
				end,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				cmp = {
					enabled = true,
				},
			},
		})

		local cmp = require("cmp")
		local config = cmp.get_config()
		table.insert(config.sources, { name = "crates" })
		cmp.setup(config)
	end,
}
