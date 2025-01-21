vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open explorer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down while keeping cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up while keeping cursor centered" })
vim.keymap.set("n", "<PageDown>", "<PageDown>zz", { desc = "Jump down while keeping cursor centered" })
vim.keymap.set("n", "<PageUp>", "<PageUp>zz", { desc = "Jump up while keeping cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search while keeping cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search while keeping cursor centered" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system register" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Deleting to void register" })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })


vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Quickfix: go to previous entry" })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Quickfix: go to next entry" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Location list: go to previous entry" })  -- ?
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Location List: go to next entry" })  -- ?

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })

-- keymaps
-- vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Write buffer" })


-- -- disable mouse and arrows
-- vim.opt.mouse = "" -- disable mouse
-- for _, key in ipairs({"<Up>", "<Down>", "<Left>", "<Right>"}) do
--     vim.keymap.set("n", key, "<Nop>", { noremap = true })
--     -- vim.keymap.set('i', key, '<Nop>', { noremap = true })
--     -- vim.keymap.set('c', key, '<Nop>', { noremap = true })
-- end