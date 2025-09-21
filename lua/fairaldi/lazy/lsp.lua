return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
			-- LSPs
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
			-- UI
			"j-hui/fidget.nvim",
        },
        config = function()
			require("fidget").setup({})
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
                    "basedpyright",
                    "ruff",
				},
				handlers = {
					function(server_name) -- default handler
						require("lspconfig")[server_name].setup {
							capabilities = capabilities,
						}
					end,
					-- ["basedpyright"] = function()
					-- 	vim.lsp.enable("basedpyright")
					-- end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup {
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									}
								}
							}
						}
					end,
				}
			})
			-- vim.diagnostic.config({
			-- 	float = {
			-- 		focusable = false,
			-- 		style = "minimal",
			-- 		border = "rounded",
			-- 		source = "always",
			-- 		header = "",
			-- 		prefix = "",
			-- 	},
			-- })
        end
    },
	{
		"ray-x/lsp_signature.nvim",  -- a simpler alternative is "hrsh7th/cmp-nvim-lsp-signature-help"
		event = "InsertEnter",
		opts = function()
			require("lsp_signature").on_attach({
				max_width = 88,
				wrap = false,
				hint_enable = false,
				timer_interval = 400,
			})
		end,
	},
}
