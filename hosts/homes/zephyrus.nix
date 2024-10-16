{ pkgs, ... }: {
  imports = [ ./common.nix ];

  programs.hyprlock.settings = {
    input-field = [{
      size = "200, 50";
      position = "0, -80";
      monitor = "eDP-1";
      dots_center = true;
      fade_on_empty = false;
      outline_thickness = 5;
      placeholder_text = "Password...";
      shadow_passes = 2;
    }];
  };

  desktop = {
    hyprland = {
      enable = true;
      extraSettings = {
        monitor = [ "eDP-1,1920x1080@144,0x0,1" ];

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
    };
  };
}
