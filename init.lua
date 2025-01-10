-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
    )
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- basic settings
vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- enable relative line numbers
vim.opt.tabstop = 4 -- number of spaces a tab represents
vim.opt.shiftwidth = 4 -- number of spaces for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent = true -- automatically indent new lines
vim.opt.wrap = false -- disable line wrapping
vim.opt.cursorline = true -- highlight the current line
vim.opt.termguicolors = true -- enable 24-bit rgb colors
vim.opt.history = 1000 -- set the command history size
vim.opt.showmatch = true -- show matching words during a search
vim.opt.wildmode = "list:longest"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.colorcolumn = "88"

-- syntax highlighting and filetype plugins
-- vim.cmd('syntax enable')
-- vim.cmd('filetype plugin indent on')

-- leader key
vim.g.mapleader = " " -- space as the leader key
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- keymaps
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Write buffer" })
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { noremap = true, desc = "Format with null-ls" })  -- requires null-ls
vim.keymap.set("n", "<leader>a", "ggVG", { noremap = true, desc = "Select all" })

-- disable mouse and arrows
vim.opt.mouse = "" -- disable mouse
for _, key in ipairs({"<Up>", "<Down>", "<Left>", "<Right>"}) do
    vim.keymap.set("n", key, "<Nop>", { noremap = true })
    -- vim.keymap.set('i', key, '<Nop>', { noremap = true })
    -- vim.keymap.set('c', key, '<Nop>', { noremap = true })
end

--plugins
require("lazy").setup(
    {
        -- colorschemes
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },
        -- LSPs (requires nodejs)
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim"
            },
            config = function()
                local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
                require("mason").setup()
                require("mason-lspconfig").setup({
					ensure_installed = { 
						"pyright",
						"ruff",
					}
				})
				
				local lsp_config = require("lspconfig")
                lsp_config.pyright.setup({
					capabilities = capabilities,
					filetypes = { "python" },
				})
                lsp_config.ruff.setup({
					filetypes = { "python" },
				})
            end
        },
		{
			"ray-x/lsp_signature.nvim",  -- simpler alternative "hrsh7th/cmp-nvim-lsp-signature-help"
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
        -- code completion
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
            },
            config = function()
                local has_words_before = function()
                    unpack = unpack or table.unpack
                    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                end

                local cmp = require("cmp")
                cmp.setup({
					mapping = cmp.mapping.preset.insert({
						["<Tab>"] = cmp.mapping(
							function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								elseif has_words_before() then
									cmp.complete()
								else
									fallback()
								end
							end,
							{ "i", "s" }
						),
						["<S-Tab>"] = cmp.mapping(
							function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								else
									fallback()
								end
							end,
							{ "i", "s" }
						),
						["<C-e>"] = cmp.mapping(  -- (originally <C-Space> but not working on Windows)
							function(fallback)
								if cmp.visible() then
									cmp.abort()
								else
									cmp.complete()
								end
							end,
							{ "i", "s" }
						),
						["<CR>"] = cmp.mapping.confirm({select = true})
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "path" },
					}, {
						{ name = "buffer" },
					})
				})
				cmp.setup.cmdline({ '/', '?' }, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" }
					}
				})
				cmp.setup.cmdline(':', {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" }
					}, {
						{ name = "cmdline" }
					}),
					matching = { disallow_symbol_nonprefix_matching = false }
				})
            end
        },
		-- syntax highlighter
		{
			"nvim-treesitter/nvim-treesitter", 
			version = false,
			build = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "python" },
					auto_install = false,
					highlight = { 
						enable = true, 
						additional_vim_regex_highlighting = false,
					},
					indent = { 
						enable = true,
					},
				})
			end
		},
		{
			"sustech-data/wildfire.nvim",  -- better incremental selection
			event = "VeryLazy",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("wildfire").setup()
			end,
		},
		-- telescope (requires ripgrep and fd)
		{ 
			"nvim-telescope/telescope.nvim", 
			cmd = "Telescope", 
			version = false,
			dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{ "<leader>sf", "<cmd>Telescope git_files show_untracked=true<cr>", desc = "Find Git Files (root dir)" },
				{ "<leader>sF", "<cmd>Telescope find_files hidden=true find_command=fd<cr>", desc = "Find Files (any dir)" },
				{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
				{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Project" },
				{ "<leader>ss", "<cmd>Telescope lsp_document_symbols show_line=true<cr>", desc = "Search Document Symbols" },
				{ "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols show_line=true<cr>", desc = "Search Workspace Symbols" },
			},
			opts = {
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case"
					}
				}
			}
		},
		{ 
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end
		},
		-- linters & formatters
		{ 
			"jose-elias-alvarez/null-ls.nvim",
			dependencies = { 
				"nvim-lua/plenary.nvim",
                "williamboman/mason.nvim",
                "jay-babu/mason-null-ls.nvim",
			},
			config = function()
				require("mason").setup()
				require("mason-null-ls").setup({
					ensure_installed = { 
						"ruff", 
						"mypy",
					},
				})
				
				-- check https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
				local null_ls = require("null-ls")
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.ruff,
						null_ls.builtins.diagnostics.ruff,
						null_ls.builtins.diagnostics.mypy.with({
							-- command = { "python", "-m", "mypy" },
							extra_args = { "--ignore-missing-imports" },
						}),
					},
					-- on_attach = function(client, bufnr)  -- autoformat on save
					-- 	if client.supports_method("textDocument/formatting") then
					-- 		vim.api.nvim_clear_autocmds({ 
					-- 			group = augroup, 
					-- 			buffer = bufnr,
					-- 		})
					-- 		vim.api.nvim_create_autocmd("BufWritePre", {
					-- 			group = augroup,
					-- 			buffer = bufnr,
					-- 			callback = function()
					-- 				vim.lsp.buf.format({ bufnr = bufnr })
					-- 			end,
					-- 		})
					-- 	end
					-- end
				})
			end,
		},
		-- comments
		{
			"numToStr/Comment.nvim",
			opts = {
				ignore = "^$",  -- ignore empty lines
				toggler = { line = "<leader>/" },
				opleader = { line = "<leader>/" },
			},
		},
		-- info, warning and error display
		{
			"folke/trouble.nvim",
			opts = {},
			cmd = "Trouble",
			keys = { 
				{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
				{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			},
		},
		-- status and buffer lines
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
		{ 
			"akinsho/bufferline.nvim", 
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
		-- auto bracket
		{
			"echasnovski/mini.pairs",
			opts = {},
		},
		-- terminal
		{ 
			"akinsho/toggleterm.nvim", 
			version = "*",	
			event = "VeryLazy", 
			opts = {
				size = 10,
				open_mapping = "<C-t>",
			},
		},
		-- git 
		{
			"tpope/vim-fugitive",
			version = "*",
			event = "VeryLazy", 
		},
		-- docstrings
		{
			"kkoomen/vim-doge",  -- must run ":call doge#install()" to finalize installation
			config = function()
				vim.g.doge_doc_standard_python = "numpy"
				vim.g.doge_python_settings = {
					single_quotes = 0,
					omit_redundant_param_types = 0,
				}
			end,
		},
		-- TODO: workspace view plugin
		-- TODO: LSP keys: go to definition, rename, etc. (where have I seen them?)  /nvim-treesitter/nvim-treesitter-textobjects
		-- TODO: python dab
		-- TODO: copilot completion
		-- TODO: undo tree plugin
		-- TODO: add support for pasting from Windows
		-- TODO: command for folding all files, e.g., :Fold level1 + shortcut for unfolding all and parts https://github.com/kevinhwang91/nvim-ufo
    }
)

-- set the colorscheme
vim.cmd.colorscheme "tokyonight"
