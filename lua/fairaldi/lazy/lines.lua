return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "palenight", refresh = { refresh_time = 32 } },
				sections = {
					lualine_c = {
						"filename",
						{
							-- https://www.reddit.com/r/neovim/comments/16ya0fr/show_the_current_python_virtual_env_on_statusline
							function()
								local conda_env = os.getenv("CONDA_DEFAULT_ENV")
								local venv_path = os.getenv("VIRTUAL_ENV")

								if venv_path == nil then
									if conda_env == nil then
										return ""
									else
										return conda_env .. " (conda)"
									end
								else
									local venv_name = vim.fn.fnamemodify(venv_path, ":t")
									return venv_name .. " (venv)"
								end
							end,
							-- cond = function()
							-- 	return vim.bo.filetype == "python"
							-- end,
						},
					},
					lualine_z = { "searchcount", "location" },
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Move to next buffer" },
			{ "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Move to previous buffer" },
			{ "<leader><", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
			{ "<leader>>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
			{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Close current buffer" },
		},
	},
}
