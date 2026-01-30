{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development.editors.vscode;
in {
  options.userapps.development.editors.vscode = with lib; {
    enable = mkEnableOption "Enable vscode text editor";
  };

  config = lib.mkIf cfg.enable {
    home = {
      sessionVariables = {
        GEMINI_SANDBOX = "true";
      };
      packages = with pkgs; [
        gemini-cli-bin
      ];
    };

    programs = {
      vscode = {
        enable = true;
        package = pkgs.antigravity;
      };
    };
  };
}
