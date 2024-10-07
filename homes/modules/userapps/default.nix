{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  options = {
    userapps.enable = lib.mkEnableOption "Enable office programs";
  };

  office = pkgs.lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      discord
      signal-desktop

      # Office work
      onlyoffice-desktopeditors
      slack

      # Gaming applications
      steam
      protontricks
      gamemode
      gamescope
    ];
  };
}
