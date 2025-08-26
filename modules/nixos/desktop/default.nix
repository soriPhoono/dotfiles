{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./environments/gnome.nix
    ./environments/kde.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable core desktop configurations";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      carlito
    ];

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
