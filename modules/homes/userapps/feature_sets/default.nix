{ lib, pkgs, config, ... }:
let
  cfg = config.userapps;
in
{
  imports = [
    ./streaming.nix
  ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      bleachbit

      discord

      obsidian
    ];

    userapps.programs = {
      firefox.enable = true;

      vscode.enable = true;
    };
  };
}
