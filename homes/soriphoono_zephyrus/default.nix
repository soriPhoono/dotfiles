{ config
, nixosConfig
, inputs
, lib
, pkgs
, username
, ...
}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops

    ../modules/core

    ../modules/themes/catppuccin.nix

    ../modules/hyprland
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080@144,0x0,1"
    ];

    bind = with pkgs; [
      ", XF86Launch1, exec, ${asusctl}/bin/rog-control-center"
      ", XF86Launch2, exec, "
      ", XF86Launch3, exec, "
      ", XF86Launch4, exec, ${asusctl}/bin/asusctl profile -n"

      ", XF86KbdBrightnessUp, exec, ${asusctl}/bin/asusctl -n"
      ", XF86KbdBrightnessDown, exec, ${asusctl}/bin/asusctl -p"
    ];

    bindl = with pkgs; [
      ", switch:on:473c56e0, exec, ${hyprland}/bin/hyprctl dispatch dpms off"
      ", switch:off:473c56e0, exec, ${hyprland}/bin/hyprctl dispatch dpms on"
    ];
  };
}
