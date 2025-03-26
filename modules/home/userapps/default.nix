{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./programs/bitwarden.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/thunderbird.nix
    ./programs/joplin-desktop.nix
    ./programs/obs-studio.nix

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

      qbittorrent
      ytmdl
    ];

    userapps.programs = {
      bitwarden.enable = true;
      firefox.enable = true;
      thunderbird.enable = true;
      joplin-desktop.enable = true;
    };

    core.impermanence.directories = [
      ".config/discord"

      ".config/Signal"
    ];
  };
}
