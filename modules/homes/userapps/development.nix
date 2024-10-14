{ lib, pkgs, config, ... }:
let
  cfg = config.userapps.development;
in {
  imports = [
    ./programs/vscode.nix
  ];

  options = {
    userapps.development.enable = lib.mkEnableOption "Enable development user applications";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian

      blender
    ];

    xdg.configFile = {
      "electron-flags.conf" = {
        enable = true;

        source = ''
        --enable-features=WebRTCPipeWireCapturer
        --ozone-platform-hint=auto
        '';
      };
    };

    userapps.programs.vscode.enable = true;
  };
}
