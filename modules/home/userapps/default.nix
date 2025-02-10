{pkgs, ...}: {
  imports = [
    ./development.nix
  ];

  # Look into LMMS
  home.packages = with pkgs; [
    thunderbird
    signal-desktop
    element-desktop

    gimp
    obs-studio
    tenacity

    discord
    betterdiscordctl
  ];
}
