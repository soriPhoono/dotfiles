{ lib, pkgs, config, ... }:
let cfg = config.programs.desktop;
in {
  options = {
    programs.desktop.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
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

    programs.firefox.enable = true;
  };
}
