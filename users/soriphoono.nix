{ lib, ... }: {
  imports = [
  ];

  programs.home-manager.enable = true;

  home.stateVersion = lib.mkDefault "24.11";
}
