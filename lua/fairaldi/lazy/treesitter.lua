return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "vimdoc", "lua", "python", "bash", "c" },
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
            })

            -- Folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            context = require("treesitter-context")
            context.setup()
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
            vim.keymap.set("n", "[c", function()
                context.go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
    {
        "sustech-data/wildfire.nvim", -- better incremental selection
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup()
        end,
    },
}
