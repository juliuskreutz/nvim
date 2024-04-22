return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		local gs = require("gitsigns")

		gs.setup()

		vim.keymap.set("n", "<leader>g", gs.preview_hunk_inline)
	end,
}
