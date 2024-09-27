{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      libva-utils
      vdpauinfo
      clinfo
      glxinfo
      vulkan-tools

      gnome-disk-utility

      discord
    ];

    shellAliases = with pkgs; {
      top = "${btop}/bin/btop";
      gtop = "${nvtopPackages.full}/bin/nvtop";
    };
  };
}
