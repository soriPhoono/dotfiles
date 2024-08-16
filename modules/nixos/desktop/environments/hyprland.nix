{ inputs, lib, config, system, ... }:
let cfg = config.desktop.environments.hyprland;
in {
  options = {
    desktop.environments.hyprland.enable = lib.mkEnableOption "Enable Hyprland Desktop";
  };

  config = lib.mkIf cfg.enable {
    desktop.environments.pipewire.enable = true;

    programs.hyprland = {
      enable = true;

      package = inputs.hyprland.packages.${system}.hyprland;
    };
  };
}
