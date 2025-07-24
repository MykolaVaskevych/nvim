return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "3rd/image.nvim",
  },
  opts = {
    lang = "python3",
    image_support = true,
    logging = false,
  },

  keys = {
    -- Main
    { "<leader>lm", "<cmd>Leet menu<cr>", desc = "Menu" },
    { "<leader>ll", "<cmd>Leet list<cr>", desc = "List problems" },
    { "<leader>ld", "<cmd>Leet daily<cr>", desc = "Daily challenge" },
    { "<leader>lr", "<cmd>Leet random<cr>", desc = "Random problem" },
    { "<leader>lt", "<cmd>Leet tabs<cr>", desc = "Switch tabs" },

    -- Execute
    { "<leader>lR", "<cmd>Leet run<cr>", desc = "Run" },
    { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit" },

    -- Code
    { "<leader>ly", "<cmd>Leet yank<cr>", desc = "Yank code" },
    { "<leader>lx", "<cmd>Leet reset<cr>", desc = "Reset code" },
    { "<leader>lL", "<cmd>Leet last_submit<cr>", desc = "Last submission" },

    -- UI
    { "<leader>lc", "<cmd>Leet console<cr>", desc = "Console" },
    { "<leader>li", "<cmd>Leet info<cr>", desc = "Info" },
    { "<leader>lo", "<cmd>Leet open<cr>", desc = "Open in browser" },
    { "<leader>le", "<cmd>Leet exit<cr>", desc = "Exit" },

    -- Filters
    { "<leader>lfe", "<cmd>Leet list difficulty=Easy<cr>", desc = "Easy" },
    { "<leader>lfm", "<cmd>Leet list difficulty=Medium<cr>", desc = "Medium" },
    { "<leader>lfh", "<cmd>Leet list difficulty=Hard<cr>", desc = "Hard" },
    { "<leader>lfa", "<cmd>Leet list status=AC<cr>", desc = "Accepted" },

    -- Random by difficulty
    { "<leader>lre", "<cmd>Leet random difficulty=Easy<cr>", desc = "Random easy" },
    { "<leader>lrm", "<cmd>Leet random difficulty=Medium<cr>", desc = "Random medium" },
    { "<leader>lrh", "<cmd>Leet random difficulty=Hard<cr>", desc = "Random hard" },
  },

  config = function(_, opts)
    require("leetcode").setup(opts)

    local wk = require("which-key")
    wk.add({
      { "<leader>l", group = "Leetcode" },
      { "<leader>lf", group = "Filter" },
      { "<leader>lr", group = "Random" },
    })
  end,
}
