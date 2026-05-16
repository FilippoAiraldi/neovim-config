local datapath = vim.fn.stdpath("data")
local lazypath = datapath .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = "fairaldi.lazy",
    lockfile = datapath .. "/lazy-lock.json",
})
