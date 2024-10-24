{ lib, pkgs, config, ... }:
let
  cfg = config.userapps.development;
in
{
  options = {
    userapps.development = {
      enable = lib.mkEnableOption "Enable development user applications";
      advanced = lib.mkEnableOption "Enable advanced development applications";
    };
  };

  config =
    let
      packages = with pkgs; [
        obsidian
      ];

      advanced_packages = with pkgs; [
        unityhub
      ];
    in
    lib.mkIf cfg.enable {
      home.packages = packages ++ (if cfg.advanced then advanced_packages else [ ]);

      userapps.programs.vscode.enable = true;
    };
}
