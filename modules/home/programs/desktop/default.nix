{ lib, pkgs, config, enable, ... }:
let cfg = config.programs.desktop;
in {
  options = {
    programs.development.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.desktop.enable {
    home.packages = with pkgs; lib.mkIf enable [
      usbutils
      pciutils

      nvtopPackages.full

      libva-utils
      vdpauinfo
      clinfo
      glxinfo
      vulkan-tools
      wayland-utils

      unzip
      p7zip

      discord
      betterdiscordctl

      obsidian

      gimp
      obs-studio
      audacity
      blender
      davinci-resolve

      lutris
      heroic

      bottles

      prismlauncher

      path-of-building
    ];
  };
}
