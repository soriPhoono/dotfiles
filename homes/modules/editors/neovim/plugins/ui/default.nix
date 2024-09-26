{
  imports = [
    ./neo-tree.nix
    ./lualine.nix
    ./telescope.nix
  ];

  programs.nixvim.plugins = {
    gitgutter.enable = true;
    which-key.enable = true;
  };
}

