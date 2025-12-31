{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in
  with lib; {
    imports = [
      ./conf/hypr.nix

      ./shell.nix
    ];

    options.environments.hyprland.default = {
      enable = mkEnableOption "Enable default hyprland desktop";
    };

    config = mkIf (config.environments.hyprland.enable && !config.environments.hyprland.custom) {
      environments.hyprland.default.enable = true;
    };
  }
