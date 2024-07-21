{ lib, pkgs, config, ... }:
let cfg = config.desktops.programs;
in {
  options = {
    desktops.programs.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian

      discord
      betterdiscordctl

      telegram-desktop
      signal-desktop
    ];

    programs = {
      firefox.enable = true;
    };
  };
}
