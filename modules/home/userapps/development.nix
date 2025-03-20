{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development;
in {
  options.userapps.development.enable = lib.mkEnableOption "Enable development software";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Communication tools
      element-desktop
    ];

    userapps.programs.vscode.enable = true;

    core.impermanence.directories = [
      ".config/Element"
    ];
  };
}
