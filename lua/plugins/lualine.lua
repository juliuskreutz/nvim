return {
	"nvim-lualine/lualine.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			sections = {
				lualine_b = {
					{
						"macro-recording",
						fmt = function()
							local reg = vim.fn.reg_recording()
							if reg == "" then
								return ""
							else
								return "Recording @" .. reg
							end
						end,
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("RecordingEnter", {
			callback = function()
				lualine.refresh({
					place = { "statusline" },
				})
			end,
		})

		vim.api.nvim_create_autocmd("RecordingLeave", {
			callback = function()
				local timer = vim.loop.new_timer()
				timer:start(
					50,
					0,
					vim.schedule_wrap(function()
						lualine.refresh({
							place = { "statusline" },
						})
					end)
				)
			end,
		})
	end,
}
