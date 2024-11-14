{ pkgs, ... }: {
  home.packages = with pkgs; [
    (prismlauncher-qt5.override {
      jdks = [
        zulu8
        zulu
      ];
    })

    path-of-building
  ];
}