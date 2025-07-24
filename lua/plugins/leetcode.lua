return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    lang = "python3",
    image_support = true,
    logging = false,
  },
  keys = {
    -- Primary actions (most used - single keys)
    { "<leader>ll", "<cmd>Leet<cr>", desc = "Menu (Dashboard)" },
    { "<leader>lr", "<cmd>Leet run<cr>", desc = "Run code" },
    { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit solution" },
    { "<leader>lt", "<cmd>Leet test<cr>", desc = "Test code" },
    { "<leader>lq", "<cmd>Leet exit<cr>", desc = "Quit Leetcode" },

    -- Problem navigation
    { "<leader>lnl", "<cmd>Leet list<cr>", desc = "List all" },
    { "<leader>lnd", "<cmd>Leet daily<cr>", desc = "Daily challenge" },
    { "<leader>lnr", "<cmd>Leet random<cr>", desc = "Random problem" },
    { "<leader>lnt", "<cmd>Leet tabs<cr>", desc = "Switch tabs" },

    -- Filtered lists
    { "<leader>lfe", "<cmd>Leet list difficulty=Easy<cr>", desc = "Easy problems" },
    { "<leader>lfm", "<cmd>Leet list difficulty=Medium<cr>", desc = "Medium problems" },
    { "<leader>lfh", "<cmd>Leet list difficulty=Hard<cr>", desc = "Hard problems" },
    { "<leader>lfa", "<cmd>Leet list status=AC<cr>", desc = "Accepted" },
    { "<leader>lfn", "<cmd>Leet list status=NOT_STARTED<cr>", desc = "Not started" },

    -- Random with difficulty
    { "<leader>lae", "<cmd>Leet random difficulty=Easy<cr>", desc = "Random easy" },
    { "<leader>lam", "<cmd>Leet random difficulty=Medium<cr>", desc = "Random medium" },
    { "<leader>lah", "<cmd>Leet random difficulty=Hard<cr>", desc = "Random hard" },

    -- Code management
    { "<leader>lcy", "<cmd>Leet yank<cr>", desc = "Yank code" },
    { "<leader>lcr", "<cmd>Leet reset<cr>", desc = "Reset to default" },
    { "<leader>lcl", "<cmd>Leet last_submit<cr>", desc = "Load last submission" },
    { "<leader>lcL", "<cmd>Leet lang<cr>", desc = "Change language" },

    -- UI/View
    { "<leader>lvc", "<cmd>Leet console<cr>", desc = "Toggle console" },
    { "<leader>lvd", "<cmd>Leet desc<cr>", desc = "Toggle description" },
    { "<leader>lvi", "<cmd>Leet info<cr>", desc = "Problem info" },
    { "<leader>lvo", "<cmd>Leet open<cr>", desc = "Open in browser" },
  },
}
