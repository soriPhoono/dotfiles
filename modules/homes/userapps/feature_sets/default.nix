{ lib, pkgs, config, ... }:
let
  cfg = config.userapps.feature_sets;
in
{
  imports = [
    ./artwork.nix
    ./streaming.nix
  ];

  options = { userapps.feature_sets.global = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.global {
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
