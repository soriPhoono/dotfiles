function theme(flavour)
  local C = require("catppuccin.palettes").get_palette(flavour)
  local O = require("catppuccin").options
  local catppuccin = {}

  local transparent_bg = O.transparent_background and "NONE" or C.mantle

  catppuccin.normal = {
    a = { bg = C.blue, fg = C.mantle, gui = "bold" },
    b = { bg = C.surface0, fg = C.blue },
    c = { bg = transparent_bg, fg = C.text },
  }

  catppuccin.insert = {
    a = { bg = C.green, fg = C.base, gui = "bold" },
    b = { bg = C.surface0, fg = C.green },
  }

  catppuccin.terminal = {
    a = { bg = C.green, fg = C.base, gui = "bold" },
    b = { bg = C.surface0, fg = C.green },
  }

  catppuccin.command = {
    a = { bg = C.peach, fg = C.base, gui = "bold" },
    b = { bg = C.surface0, fg = C.peach },
  }

  catppuccin.visual = {
    a = { bg = C.mauve, fg = C.base, gui = "bold" },
    b = { bg = C.surface0, fg = C.mauve },
  }

  catppuccin.replace = {
    a = { bg = C.red, fg = C.base, gui = "bold" },
    b = { bg = C.surface0, fg = C.red },
  }

  catppuccin.inactive = {
    a = { bg = transparent_bg, fg = C.blue },
    b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
    c = { bg = transparent_bg, fg = C.overlay0 },
  }

  return catppuccin
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        theme = theme("frappe"),
        component_separators = "",
        section_separators = {
          left = "",
          right = "",
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = {
              left = "",
            },
            right_padding = 2,
          },
        },
        lualine_b = {
          "filename",
          "branch",
        },
        lualine_c = {
          "%=",
        },
        lualine_x = {},
        lualine_y = {
          "filetype",
          "diagnostics",
        },
        lualine_z = {
          {
            "progress",
            separator = {
              right = "",
            },
            left_padding = 2,
          },
        },
      },
      inactive_sections = {
        lualine_a = {
          "filename",
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          "location",
        },
      },
      tabline = {},
      extensions = {
        "neo-tree",
        "mason",
        "toggleterm",
        "trouble",
      },
    },
  },
}
