{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./programs
  ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # System tools
      file-roller

      # General applications
      discord
      signal-desktop

      clementine

      krita
      gimp
      audacity
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
