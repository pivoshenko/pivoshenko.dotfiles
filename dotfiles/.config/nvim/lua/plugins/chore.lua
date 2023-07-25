return {
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },
    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require("mini.files").setup()
        end,
        keys = {
            {
                "<leader>m",
                function()
                    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Open mini.files (directory of current file)",
            },
            {
                "<leader>M",
                function()
                    require("mini.files").open(vim.loop.cwd(), true)
                end,
                desc = "Open mini.files (cwd)",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = { lsp = { auto_attach = true } },
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
        end,
    },
    { "wakatime/vim-wakatime" },
}
