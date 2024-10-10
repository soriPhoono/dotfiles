{ lib, pkgs, config, ... }:
let cfg = config.userapps.development;
in {
  options = {
    userapps.development.enable =
      lib.mkEnableOption "Enable development environment support";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
      vscode-fhs
    ];
  };
}
