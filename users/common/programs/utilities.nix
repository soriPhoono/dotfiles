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
  ];
}
