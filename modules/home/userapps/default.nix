{
  lib,
  config,
  ...
}: let
  cfg = config.userapps;
in
  with lib; {
    imports = [
      ./browsers/firefox.nix
      ./browsers/librewolf.nix
      ./browsers/chrome.nix
      ./browsers/floorp.nix

      ./office/bitwarden.nix
      ./office/nextcloud.nix
      ./office/obsidian.nix
      ./office/onlyoffice.nix

      ./communication/discord.nix

      ./development/editors/vscode.nix
      ./development/terminal/kitty.nix
    ];

    options.userapps = {
      enable = mkEnableOption "Enable core applications and default feature-set";
    };

    config = mkIf cfg.enable {
      services = {
        psd = {
          enable = true;
          resyncTimer = "10m";
        };
      };

      userapps = {
        office.bitwarden.enable = true;
        office.nextcloud.enable = true;
        office.obsidian.enable = true;
        office.onlyoffice.enable = true;

        communication.discord.enable = true;
      };
    };
  }
