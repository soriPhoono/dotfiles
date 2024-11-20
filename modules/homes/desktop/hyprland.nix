{ lib, config, ... }:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland desktop module";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      
      settings = {
        "$mod" = "SUPER";
        
        bind = [
          "$mod, Return, exec, kitty"
        ];
      };
    };
  };
}
