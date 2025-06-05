return {
    -- {
    -- 	"nvim-lualine/lualine.nvim",
    -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 	opts = {},
    -- },
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

