{ lib, pkgs, config, ... }:
let cfg = config.userapps.programs.vscode;
in {
  options = {
    userapps.programs.vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      package = pkgs.vscode-fhs;
    };
  };
}
