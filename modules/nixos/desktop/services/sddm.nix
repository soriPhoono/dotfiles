{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.sddm;
in {
  options = {
    desktop.services.sddm = {
      enable = lib.mkEnableOption "Enable sddm display manager";

      useKWin = lib.mkOption {
        type = lib.types.bool;
        default = false;

        description = "Use kwin compositor for sddm backend";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      sddm = {
        enable = true;

        wayland = {
          enable = true;
          compositor = if cfg.useKWin then "kwin" else "weston";
        };

        extraPackages = with pkgs; [
          elegant-sddm
        ];

        theme = "Elegant";
      };
    };
  };
}
