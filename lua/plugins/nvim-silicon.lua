return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  keys = {
    -- Copy to clipboard only (no file saved)
    {
      "<leader>cpy",
      function()
        require("nvim-silicon").clip()
      end,
      mode = { "n", "v" },
      desc = "Copy code screenshot to clipboard",
    },
    -- Save as file only (no clipboard)
    {
      "<leader>cpf",
      function()
        require("nvim-silicon").file()
      end,
      mode = { "n", "v" },
      desc = "Save code screenshot as file",
    },
    -- Save to file AND copy to clipboard
    {
      "<leader>cpc",
      function()
        require("nvim-silicon").shoot()
      end,
      mode = { "n", "v" },
      desc = "Save and copy code screenshot",
    },
    -- Save, copy, and preview image
    {
      "<leader>cpp",
      function()
        local silicon = require("nvim-silicon")
        silicon.shoot()

        -- Wait for file creation then open with explorer.exe
        vim.defer_fn(function()
          local output_path = silicon.options.output
          if type(output_path) == "function" then
            output_path = output_path()
          end

          if output_path then
            local is_wsl = vim.fn.system("uname -r"):match("WSL") or vim.fn.system("uname -r"):match("Microsoft")
            if is_wsl then
              -- Use explorer.exe to open the image (the only method that works)
              vim.fn.system('explorer.exe "' .. output_path .. '"')
            else
              local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
              vim.fn.jobstart({ open_cmd, output_path }, { detach = true })
            end
          end
        end, 500)
      end,
      mode = { "n", "v" },
      desc = "Preview code screenshot",
    },
  },
  opts = {
    -- Only override what's needed
    language = function()
      local ft = vim.bo.filetype
      -- Fix common mismatches between vim filetypes and silicon languages
      local map = {
        bash = "sh",
        sh = "sh",
        zsh = "sh",
        fish = "sh",
        javascriptreact = "jsx",
        typescriptreact = "tsx",
        javascript = "js",
        typescript = "ts",
        markdown = "md",
      }
      return map[ft] or ft
    end,

    -- Output to Windows Pictures folder
    output = function()
      -- Get Windows user home from environment
      local win_user = vim.fn.system("cmd.exe /c echo %USERPROFILE%"):gsub("\r\n", ""):gsub("\n", "")
      -- Convert to WSL path
      local pictures_path = vim.fn.system("wslpath '" .. win_user .. "\\Pictures'"):gsub("\n", "")
      return pictures_path .. "/code_" .. os.date("!%Y%m%d_%H%M%S") .. ".png"
    end,

    -- Auto-detect WSL for clipboard
    wslclipboard = "auto",

    -- Both clipboard and file by default
    to_clipboard = true,
  },
}
