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
				lua = { "stylua" },
				markdown = { "prettier" },
				json = { "prettier" },
				sh = { "beautysh" },
				zsh = { "beautysh" },
				python = { "black" },
				sql = { "pg_format" },
				toml = { "taplo" },
			},
			format_on_save = {
				lsp_fallback = true,
			},
		})
	end,
}
