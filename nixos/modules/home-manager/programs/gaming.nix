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

  xdg.desktopEntries.path-of-building = {
    name = "Path of Building";
    genericName = "build planner";

    exec = "pobfrontend";
    terminal = false;

    categories = [
      "Application"
    ];
  };
}
