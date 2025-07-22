{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./gnome.nix
    ./kde.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable base desktop kit";
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
    };

    security.rtkit.enable = true;
  };
}
