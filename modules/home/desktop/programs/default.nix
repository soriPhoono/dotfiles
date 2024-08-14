{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  options = {
    desktop.programs.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      google-chrome

      lite
      obsidian

      discord

      telegram-desktop
      signal-desktop
    ];
  };
}
