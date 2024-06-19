{ pkgs, ... }: {
  home.packages = with pkgs; [
    winetricks

    protontricks
    protonup-qt

    lutris
    heroic

    bottles

    prismlauncher

    path-of-building
  ];
}
