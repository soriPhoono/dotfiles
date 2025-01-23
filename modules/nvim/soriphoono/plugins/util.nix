{
  keymaps = [
    {
      action = "<cmd>LazyGit<CR>";
      key = "<leader>g";
      options = {
        silent = true;
        desc = "Open lazygit vcs manager";
      };
    }
  ];

  plugins = {
    web-devicons.enable = true;
    nvim-autopairs.enable = true;
    gitsigns.enable = true;

    which-key = {
      enable = true;
      settings.preset = "helix";
    };
  };
}
