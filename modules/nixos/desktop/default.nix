{ lib, pkgs, config, ... }:
let cfg = config.desktop;
in {
  imports = [ ./hyprland.nix ./steam.nix ];

  options = { };

  config = lib.mkIf cfg.enable { };
}
