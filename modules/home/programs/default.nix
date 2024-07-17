{ lib, pkgs, config, ... }:
let cfg = config.programs;
in {
  options = {
    programs.enable = lib.mkEnableOption "Enable userspace default programs";
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

      imagemagick

      unzip
      unrar
      p7zip

      discord
      betterdiscordctl
      yt-dlp
      spotdl
      ytmdl

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
