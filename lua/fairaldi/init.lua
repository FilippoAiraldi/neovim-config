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
        vim.keymap.set(
            "n",
            "<leader>f",
            function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
            { desc = "Format file (with conform)" }
        )
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = e.buf, desc = "Go to definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = e.buf, desc = "Display hover details" })
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { buffer = e.buf }) -- ?
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = e.buf })     -- ?
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { buffer = e.buf })
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { buffer = e.buf, desc = "Find references" })
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = e.buf, desc = "Rename symbol" })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = e.buf }) -- ?
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next,{ buffer = e.buf, desc = "Go to next diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { buffer = e.buf, desc = "Go to previous diagnostic" })
    end
})
