{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./programs
  ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      bleachbit
      signal-desktop
      youtube-music

      krita
      gimp

      onlyoffice-desktopeditors
      slack
    ];

    userapps.programs.discord.enable = true;
  };
}
