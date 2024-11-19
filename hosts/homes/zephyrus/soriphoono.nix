{
  imports = [
    ../common.nix
  ];

  desktop.hyprland.enable = true;

  userapps.feature_sets = {
    global = true;
    development = true;
    gaming = true;
  };
}
