{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.development.editors.vscode;
in {
  options.userapps.development.editors.vscode = with lib; {
    enable = mkEnableOption "Enable vscode text editor";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      vscode.enable = true;
    };
  };
}
