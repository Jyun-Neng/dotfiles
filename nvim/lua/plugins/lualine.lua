local colors = require("catppuccin.palettes").get_palette("mocha")
local function separator()
  return {
    function()
      return "│"
    end,
    color = { fg = colors.overlay0, bg = colors.base, gui = "bold" },
    padding = { left = 1, right = 1 },
  }
end
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
          color = function()
            local mode = vim.fn.mode()
            if mode == "\22" then
              return { fg = colors.base, bg = colors.red, gui = "bold" }
            elseif mode == "V" then
              return { fg = colors.red, bg = colors.base, gui = "underline,bold" }
            else
              return { fg = colors.red, bg = colors.base, gui = "bold" }
            end
          end,
          padding = { left = 1, right = 0 },
        },
      },
      lualine_b = {
        separator(),
        {
          "branch",
          color = { fg = colors.green, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
        {
          "diff",
          colored = true,
          diff_color = {
            added = { fg = colors.teal, bg = colors.base, gui = "bold" },
            modified = { fg = colors.yellow, bg = colors.base, gui = "bold" },
            removed = { fg = colors.red, bg = colors.base, gui = "bold" },
          },
          symbols = { added = "+", modified = "~", removed = "-" },
          source = nil,
          padding = { left = 0, right = 0 },
        },
      },
      lualine_c = {
        separator(),
        {
          "filetype",
          icon_only = true,
          colored = false,
          color = { fg = colors.blue, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
        {
          "filename",
          file_status = true,
          path = 0,
          shorting_target = 20,
          symbols = {
            modified = "[+]",
            readonly = "[-]",
            unnamed = "[?]",
            newfile = "[!]",
          },
          color = { fg = colors.blue, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
        separator(),
        {
          function()
            local bufnr_list = vim.fn.getbufinfo({ buflisted = 1 })
            local total = #bufnr_list
            local current_bufnr = vim.api.nvim_get_current_buf()
            local current_index = 0

            for i, buf in ipairs(bufnr_list) do
              if buf.bufnr == current_bufnr then
                current_index = i
                break
              end
            end

            return string.format(" %d/%d", current_index, total)
          end,
          color = { fg = colors.yellow, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
      },
      lualine_x = {
        {
          "fileformat",
          color = { fg = colors.yellow, bg = colors.base, gui = "bold" },
          symbols = {
            unix = "",
            dos = "",
            mac = "",
          },
          padding = { left = 0, right = 0 },
        },
        {
          "encoding",
          color = { fg = colors.yellow, bg = colors.base, gui = "bold" },
          padding = { left = 1, right = 0 },
        },
        separator(),
        {
          function()
            local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
            if size < 0 then
              return "-"
            else
              if size < 1024 then
                return size .. "B"
              elseif size < 1024 * 1024 then
                return string.format("%.1fK", size / 1024)
              elseif size < 1024 * 1024 * 1024 then
                return string.format("%.1fM", size / (1024 * 1024))
              else
                return string.format("%.1fG", size / (1024 * 1024 * 1024))
              end
            end
          end,
          color = { fg = colors.blue, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
      },
      lualine_y = {
        separator(),
        {
          "diagnostics",
          sources = { "nvim_diagnostic", "coc" },
          sections = { "error", "warn", "info", "hint" },
          diagnostics_color = {
            error = function()
              local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
              return { fg = (count == 0) and colors.green or colors.red, bg = colors.base, gui = "bold" }
            end,
            warn = function()
              local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
              return { fg = (count == 0) and colors.green or colors.yellow, bg = colors.base, gui = "bold" }
            end,
            info = function()
              local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
              return { fg = (count == 0) and colors.green or colors.blue, bg = colors.base, gui = "bold" }
            end,
            hint = function()
              local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
              return { fg = (count == 0) and colors.green or colors.teal, bg = colors.base, gui = "bold" }
            end,
          },
          symbols = {
            error = "󰅚 ",
            warn = "󰀪 ",
            info = "󰋽 ",
            hint = "󰌶 ",
          },
          colored = true,
          update_in_insert = false,
          always_visible = true,
          padding = { left = 0, right = 0 },
        },
      },
      lualine_z = {
        separator(),
        {
          "progress",
          color = { fg = colors.red, bg = colors.base, gui = "bold" },
          padding = { left = 0, right = 0 },
        },
        {
          "location",
          color = { fg = colors.red, bg = colors.base, gui = "bold" },
          padding = { left = 1, right = 0 },
        },
      },
    },
  },
}
