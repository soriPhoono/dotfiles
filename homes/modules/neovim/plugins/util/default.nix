{
  imports =
    [ ./commentary.nix ./autopairs.nix ./gitsigns.nix ./toggleterm.nix ];

  programs.nixvim.plugins.lazygit.enable = true;
}
