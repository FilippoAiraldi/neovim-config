return {
    {
        "nvim-telescope/telescope.nvim", -- requires ripgrep and fd
        cmd = "Telescope",
        version = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>sf",      "<cmd>Telescope git_files show_untracked=true<cr>",                desc = "Find Git Files (root dir)" },
            { "<leader>sF",      "<cmd>Telescope find_files hidden=true find_command=fd<cr>",       desc = "Find Files (any dir)" },
            { "<leader><space>", "<cmd>Telescope buffers<cr>",                                      desc = "Find Buffers" },
            { "<leader>sg",      "<cmd>Telescope live_grep<cr>",                                    desc = "Search Project" },
            { "<leader>ss",      "<cmd>Telescope lsp_document_symbols show_line=true<cr>",          desc = "Search Document Symbols" },
            { "<leader>sS",      "<cmd>Telescope lsp_dynamic_workspace_symbols show_line=true<cr>", desc = "Search Workspace Symbols" },
            {
                "<leader>sw",
                function()
                    local word = vim.fn.expand("<cword>")
                    require("telescope.builtin").grep_string({ search = word })
                end,
                desc = "Search Project for Current Word",
            },
            {
                "<leader>sW",
                function()
                    local word = vim.fn.expand("<cWORD>")
                    require("telescope.builtin").grep_string({ search = word })
                end,
                desc = "Search Project for Current WORD",
            },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search In Help" },
            { "<leader>sr", "<cmd>Telescope resume<cr>",    desc = "Resume Last Telescope Search" }
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
}
