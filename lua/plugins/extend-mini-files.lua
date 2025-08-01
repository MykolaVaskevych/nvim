return {
  {
    "echasnovski/mini.files",
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
      {
        "<leader>fm",
        function()
          require("mini.files").open(LazyVim.root(), true)
        end,
        desc = "Open mini.files (root)",
      },
    },
    opts = {
      options = {
        use_as_default_explorer = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
}

-- opts = {
--   mappings = {
--     go_in = "<Right>",
--     go_out = "<Left>",
--   },
--   windows = {
--     width_nofocus = 20,
--     width_focus = 50,
--     width_preview = 100,
--   },
--   options = {
--     use_as_default_explorer = true,
--   },
-- },
--
