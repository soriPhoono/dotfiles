{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # System tools
      file-roller

      # General applications
      discord
      signal-desktop

      imv
      clementine
      mpv

      krita
      gimp
      audacity
      obs-studio
      blender-hip
      davinci-resolve

      bleachbit
      onlyoffice-desktopeditors

      obsidian
      vscode-fhs
      slack
    ];
  };
}
