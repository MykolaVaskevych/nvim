return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Ensure devicetree parser is installed for ZMK keymaps
    vim.list_extend(opts.ensure_installed, {
      "devicetree",
      "html",
      "typescript",
      "tsx",
      "javascript",
    })
  end,
}
