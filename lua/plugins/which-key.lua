return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    spec = {
      -- leetcode group with subs
      { "<leader>l", group = "leetcode", icon = { icon = "󰖟", color = "orange" } },
      { "<leader>ln", group = "navigate", icon = { icon = "", color = "blue" } },
      { "<leader>lf", group = "filter", icon = { icon = "🔍", color = "green" } },
      { "<leader>la", group = "random level", icon = { icon = "󰒲", color = "purple" } },
      { "<leader>lc", group = "code", icon = { icon = "", color = "cyan" } },
      { "<leader>lv", group = "view", icon = { icon = "", color = "yellow" } },

      -- code print (silicon) group
      { "<leader>cp", group = "code print", icon = { icon = "📸", color = "green" } },
    },
  },
}
