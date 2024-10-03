{ lib, config, ... }:
let cfg = config.desktop.programs.vscode;
in { 
  options = {
    desktop.programs.vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
    };
  };
}
