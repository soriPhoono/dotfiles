{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./artwork.nix
    ./development.nix
    ./streaming.nix

    ./programs/firefox.nix
    ./programs/thunderbird.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable user applications for end-user systems";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      signal-desktop

      onlyoffice-desktopeditors
      joplin-desktop

      qbittorrent
      ytmdl
    ];

    userapps.programs = {
      firefox.enable = true;
      thunderbird.enable = true;
    };
  };
}
