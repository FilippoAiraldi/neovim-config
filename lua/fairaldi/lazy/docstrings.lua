vim.g.doge_enable_mappings = false
vim.g.doge_doc_standard_python = "numpy"
vim.g.doge_python_settings = {
	single_quotes = 0,
	omit_redundant_param_types = 0,
}

-- vim.keymap.set('n', '<Leader>d', '<Plug>(doge-generate)')
vim.keymap.set({ "n", "i", "x" }, "<TAB>", "<Plug>(doge-comment-jump-forward)")
vim.keymap.set({ "n", "i", "x" }, "<S-TAB>", "<Plug>(doge-comment-jump-backward)")

return {
	{
		"kkoomen/vim-doge",  -- must run ":call doge#install()" to finalize installation
	},
}

