{ lib, pkgs, config, ... }:
let cfg = config.programs;
in {
  options = {
    programs = {
      enable = lib.mkEnableOption "Enable userspace default programs";
      development.enable = lib.mkEnableOption "Enable development programs";
      desktop.enable = lib.mkEnableOption "Enable desktop programs";
    };
  };

  config = {
    home.packages = with pkgs; lib.mkIf cfg.enable [
      imagemagick

      unrar

      yt-dlp
      spotdl
      ytmdl
    ] ++ lib.mkIf cfg.development.enable [
      mkdocs

      gcc
      gdb
      clang-tools
      lldb
      ninja
      cmake
      meson

      zig

      rustup

      jdk

      python3

      sass

      qmk
    ] ++ lib.mkIf cfg.desktop.enable [
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
