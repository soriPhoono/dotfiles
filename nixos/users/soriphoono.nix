{ stateVersion, ... }: {
  imports = [
    ../modules/home-manager/themes/catppuccin.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${stateVersion}";
}
