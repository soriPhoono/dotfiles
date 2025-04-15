return {
  {
    "catppuccin/nvim",
    config = function()
      (require("catppuccin")).setup({
        flavour = "frappe",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
