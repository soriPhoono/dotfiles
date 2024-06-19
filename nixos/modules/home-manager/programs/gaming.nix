{ pkgs, ... }: {
  home.packages = with pkgs; [
    libratbag
    piper

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
