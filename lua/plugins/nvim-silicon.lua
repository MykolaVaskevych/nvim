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
    -- Save, copy, and open in default viewer
    {
      "<leader>cpp",
      function()
        local silicon = require("nvim-silicon")
        -- Generate output path once
        local output_path = silicon.options.output
        if type(output_path) == "function" then
          output_path = output_path()
        end

        if not output_path then
          return
        end

        -- Set output path explicitly and shoot
        silicon.options.output = output_path
        silicon.shoot()

        -- Open in default viewer
        local filename = vim.fn.fnamemodify(output_path, ":t")
        vim.fn.system('cmd.exe /c start "" "C:\\Users\\bebag\\Pictures\\' .. filename .. '"')
      end,
      mode = { "n", "v" },
      desc = "Save, copy, and open screenshot in default viewer",
    },
    -- Save, copy, and open in Paint
    {
      "<leader>cpd",
      function()
        local silicon = require("nvim-silicon")
        -- Generate output path once
        local output_path = silicon.options.output
        if type(output_path) == "function" then
          output_path = output_path()
        end

        if not output_path then
          return
        end

        -- Set output path explicitly and shoot
        silicon.options.output = output_path
        silicon.shoot()

        -- Open in Paint
        local filename = vim.fn.fnamemodify(output_path, ":t")
        vim.fn.system('cmd.exe /c mspaint "C:\\Users\\bebag\\Pictures\\' .. filename .. '"')
      end,
      mode = { "n", "v" },
      desc = "Save, copy, and open screenshot in Paint",
    },
    -- Save, copy, and open in Photos app
    {
      "<leader>cpo",
      function()
        local silicon = require("nvim-silicon")
        -- Generate output path once
        local output_path = silicon.options.output
        if type(output_path) == "function" then
          output_path = output_path()
        end

        if not output_path then
          return
        end

        -- Set output path explicitly and shoot
        silicon.options.output = output_path
        silicon.shoot()

        -- Open in Photos app
        local filename = vim.fn.fnamemodify(output_path, ":t")
        vim.fn.system(
          'powershell.exe -Command "Start-Process \\"ms-photos:\\" -ArgumentList \\"C:\\Users\\bebag\\Pictures\\'
            .. filename
            .. '\\""'
        )
      end,
      mode = { "n", "v" },
      desc = "Save, copy, and open screenshot in Photos app",
    },
    -- Screenshot from yanked/clipboard content
    {
      "<leader>cpb",
      function()
        -- Get content from clipboard/register
        local content = vim.fn.getreg('"') -- Default register (last yanked)
        if not content or content == "" then
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
        local output_path = "/mnt/c/Users/bebag/Pictures/code_" .. os.date("!%Y%m%d_%H%M%S") .. ".png"

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
          -- Open in default viewer
          local filename = vim.fn.fnamemodify(output_path, ":t")
          vim.fn.system('cmd.exe /c start "" "C:\\Users\\bebag\\Pictures\\' .. filename .. '"')
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
