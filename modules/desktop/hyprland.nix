{ inputs
, lib
, pkgs
, config
, ...
}:
let cfg = config.desktop.hyprland;
in {
  imports = [
    ./nautilus.nix
  ];

  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      enable = true;
      windowManager = true;
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };

    security.polkit.enable = true;
  };
}
