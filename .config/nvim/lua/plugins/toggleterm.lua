return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<leader>tt",
        ":ToggleTerm<CR>",
        silent = true,
      },
    },
    opts = {
      direction = "float",
    },
  },
}
