{
  imports = [ ./neo-tree.nix ./lualine.nix ./telescope.nix ./gitsigns.nix ];

  programs.nixvim.plugins.which-key.enable = true;
}
