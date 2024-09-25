{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    libva-utils
    vdpauinfo
    clinfo
    glxinfo
    vulkan-tools

    gnome.gnome-disk-utility

    discord
    telegram-desktop
    signal-desktop

    gzdoom
    prismlauncher
    path-of-building

    gimp
    audacity
    davinci-resolve
    obs-studio
  ];
}
