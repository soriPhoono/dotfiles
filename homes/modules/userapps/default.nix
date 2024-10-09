{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./gaming.nix
  ];

  options = {
    userapps.enable = lib.mkEnableOption "Enable office programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      obsidian
      discord
      signal-desktop

      # Office work
      onlyoffice-desktopeditors
      slack
    ];
  };
}
