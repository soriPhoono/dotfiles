{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.development.vscode;
in {
  options.userapps.development.vscode = with lib; {
    enable = mkEnableOption "Enable vscode text editor";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      vscode.enable = true;
    };
  };
}
