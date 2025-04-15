return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "\\",
        ":Neotree reveal<CR>",
        silent = true,
      },
    },
    lazy = false,
    opts = {
      filesystem = {
        close_if_last_window = true,
        hijack_netrw_behavior = "open_current",
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
      window = {
        position = "float",
      },
    },
  },
}
