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

        -- Wait for file creation then open
        vim.defer_fn(function()
          local output_path = silicon.options.output
          if type(output_path) == "function" then
            output_path = output_path()
          end

          if output_path then
            -- Get just the filename
            local filename = vim.fn.fnamemodify(output_path, ":t")
            -- Try different methods to open the image
            -- Method 1: Use Windows Photos app (Windows 10/11)
            local cmd = 'powershell.exe -Command "Start-Process \\"ms-photos:\\" -ArgumentList \\"C:\\Users\\bebag\\Pictures\\'
              .. filename
              .. '\\""'
            local result = vim.fn.system(cmd)

            -- If Photos app fails, try method 2: Use mspaint as fallback
            if result ~= "" then
              vim.fn.system('cmd.exe /c mspaint "C:\\Users\\bebag\\Pictures\\' .. filename .. '"')
            end

            vim.notify("Opening " .. filename, vim.log.levels.INFO)
          end
        end, 500)
      end,
      mode = { "n", "v" },
      desc = "Preview code screenshot",
    },
    -- Screenshot from yanked/clipboard content
    {
      "<leader>cpb",
      function()
        -- Get content from clipboard/register
        local content = vim.fn.getreg('"') -- Default register (last yanked)
        if not content or content == "" then
          vim.notify("No content in register", vim.log.levels.WARN)
          return
        end

        -- Create temp file with the yanked content
        local temp_file = vim.fn.tempname() .. ".txt"
        local file = io.open(temp_file, "w")
        file:write(content)
        file:close()

        -- Detect language from current buffer or prompt
        local lang = vim.bo.filetype
        local language_map = {
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
        lang = language_map[lang] or lang or "text"

        -- Generate output path
        local output_path = vim.fn.expand("~/Pictures/code_" .. os.date("!%Y%m%d_%H%M%S") .. ".png")

        -- Run silicon on the temp file
        local cmd = {
          "silicon",
          "--language",
          lang,
          "--output",
          output_path,
          temp_file,
        }

        vim.fn.system(cmd)

        -- Clean up temp file
        os.remove(temp_file)

        -- Copy to clipboard if in WSL
        local is_wsl = vim.fn.system("uname -r"):match("WSL") or vim.fn.system("uname -r"):match("Microsoft")
        if is_wsl then
          -- Also copy to clipboard
          vim.fn.system({ "silicon", "--language", lang, "--to-clipboard", temp_file })
        end

        -- Notify user
        vim.notify("Screenshot created from yanked content: " .. output_path, vim.log.levels.INFO)

        -- Open preview
        if is_wsl then
          local win_path = vim.fn.system("wslpath -w '" .. output_path .. "'"):gsub("\n", "")
          vim.fn.system('explorer.exe "' .. win_path .. '"')
        end
      end,
      mode = { "n" },
      desc = "Screenshot from buffer/yanked content",
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

    -- Save directly to Windows Pictures folder via /mnt/c (hardcoded for reliability)
    output = function()
      return "/mnt/c/Users/bebag/Pictures/code_" .. os.date("!%Y%m%d_%H%M%S") .. ".png"
    end,

    -- Auto-detect WSL for clipboard
    wslclipboard = "auto",

    -- Both clipboard and file by default
    to_clipboard = true,
  },
}
