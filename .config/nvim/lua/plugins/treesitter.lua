local special_langs = {}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,

        additional_vim_regex_highlighting = special_langs,
      },
      indent = {
        enable = true,
        disable = special_langs,
      },
    },
  },
}
