{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.soriphoono;
in {
  imports = [
    ./general.nix
    ./monitors.nix
    ./autostart.nix
    ./binds.nix
    ./rules.nix
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.variables = ["--all"];
    };
  };
}
