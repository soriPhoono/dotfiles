{
  imports = [
    ./alpha.nix
    ./cmp.nix
    ./dap.nix
    ./treesitter.nix
    ./neo-tree.nix
    ./lualine.nix
    ./telescope.nix
    ./gitsigns.nix
    ./toggleterm.nix
  ];

  programs.nixvim.plugins.which-key.enable = true;
}
