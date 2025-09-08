{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.vscode;
in {
  options.userapps.vscode = with lib; {
    enable = mkEnableOption "Enable development software";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode.enable = true;
  };
}
