{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.sddm;
in {
  options = {
    desktop.services.sddm = {
      enable = lib.mkEnableOption "Enable sddm display manager";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.elegant-sddm
    ];

    services.displayManager = {
      sddm = {
        enable = true;

        wayland = {
          enable = true;

          compositor = "kwin"; # TODO: possible bug, may need to re-enable
        };

        theme = "Elegant";
      };
    };
  };
}
