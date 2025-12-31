{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in
  with lib; {
    imports = [
      ./environments/display_managers/sddm.nix

      ./environments/cosmic.nix
      ./environments/kde.nix
      ./environments/uwsm.nix

      ./features/gaming.nix
      ./features/printing.nix
      ./features/virtualisation.nix

      ./services/asusd.nix
      ./services/pipewire.nix
    ];

    options.desktop = {
      enable = mkEnableOption "Enable core desktop configurations";

      environment = mkOption {
        type = with types; nullOr str;
        default = null;
        description = "The shorthand code for the currently enabled desktop, for autoselection of display manager";
        example = "kde";
      };
    };

    config = mkIf cfg.enable {
      desktop.services.pipewire.enable = true;

      programs = {
        appimage = {
          enable = true;
          binfmt = true;
        };
      };

      services = {
        geoclue2.enable = true;
        localtimed.enable = true;
        flatpak.enable = true;
      };
    };
  }
