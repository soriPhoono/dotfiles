{ pkgs, ... }: {
  home.packages = with pkgs; [
    wine-wayland
    winetricks
  ];
}
