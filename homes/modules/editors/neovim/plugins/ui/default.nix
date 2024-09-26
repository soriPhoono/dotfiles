{
  imports = [ ./neo-tree.nix ./lualine.nix ./telescope.nix ./toggleterm.nix];

  programs.nixvim = {
    keymaps = [{
      key = "<leader>gs";
      action = "<cmd>GitGutterBufferToggle<CR>";
      mode = [ "n" ];
      options = {
        desc = "Toggle git gutter status";
        silent = true;
      };
    }];

    plugins = {
      gitgutter = {
        enable = true;
        enableByDefault = false;
      };
      which-key.enable = true;
    };
  };
}
