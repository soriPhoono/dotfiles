{ lib, pkgs, config, ... }:
let cfg = config.userapps.programs.discord;
in {
  options = {
    userapps.programs.discord.enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
