return {
	{
		"tpope/vim-fugitive",
		version = "*",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}

