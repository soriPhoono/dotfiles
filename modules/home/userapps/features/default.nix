{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features;
in {
  imports = [
    ./artwork.nix
    ./streaming.nix
    ./development.nix
  ];

  options.userapps.features = {
    enable = lib.mkEnableOption "Enable core applications and default feature-set";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # core applications
      sublime-music
      freetube

      # communications
      signal-desktop
      element-desktop
      slack

      # productivity
      thunderbird
      onlyoffice-desktopeditors
      obsidian

      # tools
      gimp
    ];

    userapps = {
      ghostty.enable = true;
      firefox.enable = true;
      discord.enable = true;
    };
  };
}
