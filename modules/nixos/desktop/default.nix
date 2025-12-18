{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./environments/kde.nix
    ./environments/hyprland.nix

    ./features/gaming.nix
    ./features/printing.nix
    ./features/virtualisation.nix

    ./programs/uwsm.nix
    ./programs/wireshark.nix

    ./services/asusd.nix
    ./services/pipewire.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable core desktop configurations";
  };

  config = lib.mkIf cfg.enable {
    services = {
      pulseaudio.enable = false;

      pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };

      geoclue2.enable = true;
      localtimed.enable = true;
      flatpak.enable = true;
    };

    security.rtkit.enable = true;
  };
}
