{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland.soriphoono;
in {
  imports = [
    ./general.nix
    ./monitors.nix
    ./autostart.nix
    ./binds.nix
    ./rules.nix

    ./mako.nix
    ./kitty.nix
  ];

  options.hyprland.soriphoono = {
    enable = lib.mkEnableOption "Enable hyprland desktop with sane defaults";

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "The modifier key to enable hyprland hotkeys";
      default = "SUPER";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };
  };
}
