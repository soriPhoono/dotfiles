{ stateVersion, ... }: {
  imports = [
    ../modules/home-manager/core/xdg.nix
    ../modules/home-manager/core/utility-progs.nix

    ../modules/home-manager/themes/catppuccin.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${stateVersion}";
}
