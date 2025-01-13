require("fairaldi.opt")
require("fairaldi.remaps")
require("fairaldi.lazy_init")

local FairaldiGroup = vim.api.nvim_create_augroup("Fairaldi", {})

vim.api.nvim_create_autocmd("BufEnter", {
    group = FairaldiGroup,
    callback = function()
        vim.cmd.colorscheme("rose-pine-moon")
    end
})

vim.api.nvim_create_autocmd("BufWritePre", { -- remove trailing whitespaces
    group = FairaldiGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", { -- highlight yanked text
    group = FairaldiGroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = FairaldiGroup,
    callback = function(e)
		b = e.buf
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = b, desc = "Go to definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = b, desc = "Display hover details" })
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { buffer = b }) -- ?
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = b })     -- ?
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { buffer = b })
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { buffer = b, desc = "Find references" })
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = b, desc = "Rename symbol" })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = b }) -- ?
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { buffer = b, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { buffer = b, desc = "Go to previous diagnostic" })
    end
})
