{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.development;
in {
  options = {
    desktop.programs.development = {
      enable = lib.mkEnableOption "Enable development suite of gui applications";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        
      ];
    };
  };
}
