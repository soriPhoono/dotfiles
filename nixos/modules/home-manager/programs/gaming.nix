{ pkgs, ... }: {
  home.packages = with pkgs; [
    lutris
    heroic
    bottles
    winetricks
    protontricks
  ];
}
