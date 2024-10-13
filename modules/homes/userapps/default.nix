{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./programs
  ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      discord
      signal-desktop

      youtube-music

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
