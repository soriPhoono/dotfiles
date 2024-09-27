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
    rainbow-delimiters.enable = true;
    tagbar.enable = true;
    fidget.enable = true;
    transparent.enable = true;
    which-key.enable = true;
  };
}
