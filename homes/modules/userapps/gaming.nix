{ lib, pkgs, config, ... }:
let cfg = config.userapps.gaming;
in {
  options = {
    userapps.gaming.enable = lib.mkEnableOption "Enable gaming apps";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Gaming applications
      steam
      protontricks
      gamemode
      gamescope
    ];
  };
}
