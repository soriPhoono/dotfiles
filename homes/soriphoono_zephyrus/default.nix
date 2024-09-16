{ config
, nixosConfig
, inputs
, lib
, username
, ...
}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops

    ../modules/core
    ../modules/editors

    ../modules/themes/catppuccin.nix

    ../modules/hyprland
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@144,0x0,1"
    ];
  };
}
