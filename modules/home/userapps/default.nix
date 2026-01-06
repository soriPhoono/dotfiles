{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in with lib; {
  imports = [
    ./bitwarden.nix

    ./firefox.nix
    ./librewolf.nix

    ./terminal/kitty.nix

    ./development/vscode.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable core applications and default feature-set";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # core applications
      nextcloud-client
    ];

    services = {
      psd = {
        enable = true;
        resyncTimer = "10m";
      };
    };

    userapps = {
      bitwarden.enable = true;

      firefox.enable = true;
      librewolf.enable = true;
    };
  };
}
