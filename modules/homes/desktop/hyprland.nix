{ lib, config, ... }:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland = { 
      enable = lib.mkEnableOption "Enable Hyprland desktop module";
    };
  };

  config = lib.mkIf cfg.enable {
    
  };
}
