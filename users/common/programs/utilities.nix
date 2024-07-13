{ pkgs, ... }: {
  home.packages = with pkgs; [
    usbutils
    usbtop

    pciutils

    btop
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

  xdg.desktopEntries.path-of-building = {
    name = "Path of Building";
    genericName = "build planner";

    exec = "pobfrontend";
    terminal = false;

    categories = [
      "Application"
    ];
  };
}
