{ pkgs, ... }: {
  home.packages = with pkgs; [
    winetricks
    protontricks
    lutris
    heroic
    bottles
    prismlauncher
    path-of-building
  ];
}
