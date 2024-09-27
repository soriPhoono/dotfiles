{
  imports = [
    ./alpha.nix
    ./cmp.nix
    ./treesitter.nix
    ./neo-tree.nix
    ./lualine.nix
    ./telescope.nix
    ./noice.nix
  ];

  programs.nixvim.plugins = {
    notify.enable = true;

    rainbow-delimiters.enable = true;
    which-key.enable = true;
  };
}
