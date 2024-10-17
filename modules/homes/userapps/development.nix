{ lib, pkgs, config, ... }:
let
  cfg = config.userapps.development;
in
{
  imports = [
    ./programs/vscode.nix
  ];

  options = {
    userapps.development.enable = lib.mkEnableOption "Enable development user applications";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
      unityhub
    ];

    userapps.programs.vscode.enable = true;
  };
}
