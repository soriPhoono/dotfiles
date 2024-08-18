{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs;
in {
  imports = [
    ./gaming.nix
    ./streaming.nix
  ];

  options = {
    desktop.programs.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      google-chrome

      obsidian

      discord
      telegram-desktop
      signal-desktop
    ];
  };
}
