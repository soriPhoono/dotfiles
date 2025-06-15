{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features.development;
in {
  options.userapps.features.development.enable = lib.mkEnableOption "Enable development software";

  config = lib.mkIf cfg.enable {
    userapps.vscode.enable = true;
  };
}
