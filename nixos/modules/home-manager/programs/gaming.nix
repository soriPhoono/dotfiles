{ pkgs, ... }: {
  home.packages = with pkgs; [
    #piper
    #solaar

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
