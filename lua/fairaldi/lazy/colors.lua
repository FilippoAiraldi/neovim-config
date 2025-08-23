return {
	{
		"github-main-user/lytmode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("lytmode").setup({
				italic_comments = false,
				italic_inlayhints = false,
			})
			vim.cmd.colorscheme("lytmode")
		end
	},
}
