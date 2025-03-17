{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./programs/ghostty.nix
    ./programs/firefox.nix
    ./programs/bitwarden.nix
    ./programs/vscode.nix
    ./programs/thunderbird.nix
    ./programs/zathura.nix

    ./artwork.nix
    ./development.nix
    ./streaming.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable user applications for end-user systems";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
      signal-desktop

      vlc

      onlyoffice-desktopeditors
      joplin-desktop

      qbittorrent
      ytmdl
    ];

    userapps.programs = {
      ghostty.enable = true;
      firefox.enable = true;
      bitwarden.enable = true;
    };

    core.impermanence.directories = [
      ".config/discord"

      ".config/joplin-desktop"

      ".config/Signal"
    ];
  };
}
