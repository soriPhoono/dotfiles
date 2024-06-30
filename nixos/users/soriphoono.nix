{ vars, ... }: {
  imports = [ ../modules/home-manager/themes/catppuccin.nix ];

  programs.home-manager.enable = true;

  home.stateVersion = "${vars.stateVersion}";
}
