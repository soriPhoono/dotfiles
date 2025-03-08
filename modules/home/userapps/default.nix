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

    ./programs/ghostty.nix
    ./programs/firefox.nix
    ./programs/bitwarden.nix
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
      ghostty.enable = true;
      firefox.enable = true;
      bitwarden.enable = true;
      thunderbird.enable = true;
    };
  };
}
