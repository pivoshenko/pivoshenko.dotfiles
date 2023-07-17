return {
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
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup()
    end,
  },
}
