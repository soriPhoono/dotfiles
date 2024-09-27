{
  imports = [
    ./alpha.nix
    ./cmp.nix
    ./treesitter.nix
    ./neo-tree.nix
    ./lualine.nix
    ./telescope.nix
  ];

  programs.nixvim.plugins = {
    noice.enable = true;

    notify.enable = true;

    rainbow-delimiters.enable = true;
    which-key.enable = true;
  };
}
