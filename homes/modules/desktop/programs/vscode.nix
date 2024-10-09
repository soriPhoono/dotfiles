{ lib, pkgs, config, ... }: 
let cfg = config.desktop.programs.vscode;
in {
  options = {
    desktop.programs.vscode.enable = lib.mkEnableOption "Enable vscode editor support";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [

      ];
    };
  };
}
