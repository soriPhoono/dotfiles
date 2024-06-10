{ pkgs, ... }: {
  home.packages = with pkgs; [
    usbutils
    usbtop
    
    pciutils
    
    btop
    nvtopPackages.full
  ];
}
