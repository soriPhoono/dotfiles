{
  imports = [
    ./cmp.nix
    ./treesitter.nix
    ./neo-tee.nix
    ./lualine.nix
    ./telescope.nix
    ./gitsigns.nix
    ./toggleterm.nix
  ];

  programs.nixvim.plugins.which-key.enable = true;
}
