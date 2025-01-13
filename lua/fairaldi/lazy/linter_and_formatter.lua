return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
				mode = "",
				desc = "Format buffer (with conform)",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { 
					"ruff_fix", 
					"ruff_format", 
					"ruff_organize_imports",
				},
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	-- {
	-- 	"nvimtools/none-ls.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"williamboman/mason.nvim",
	-- 		"jay-babu/mason-null-ls.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("mason").setup()
	-- 		require("mason-null-ls").setup({
	-- 			ensure_installed = {
	-- 				"mypy",
	-- 			},
	-- 		})
	-- 		local null_ls = require("null-ls")
	-- 		null_ls.setup({
	-- 			sources = {
	-- 				-- null_ls.builtins.formatting.isort,
	-- 				-- null_ls.builtins.formatting.black,
	-- 				null_ls.builtins.diagnostics.mypy.with({
	-- 					-- command = { "python", "-m", "mypy" },
	-- 					extra_args = { "--ignore-missing-imports" },
	-- 				}),
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
