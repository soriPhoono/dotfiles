{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.plasma;
in {
  options.desktop.plasma = {
    enable = lib.mkEnableOption "Enable kde desktop environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "frappe";
        background = "${config.stylix.image}";
        loginBackground = true;
      })
    ];

    services = {
      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          package = lib.mkForce pkgs.kdePackages.sddm;
          wayland = {
            enable = true;
            compositor = "kwin";
          };
          theme = "catppuccin-frappe";
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
