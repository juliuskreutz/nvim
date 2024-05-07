return {
	"mbbill/undotree",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		vim.opt.swapfile = false
		vim.opt.backup = false
		local home = os.getenv("HOME")
		if home == nil then
			home = os.getenv("USERPROFILE")
		end
		vim.opt.undodir = home .. "/.vim/undodir"
		vim.opt.undofile = true

		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}
