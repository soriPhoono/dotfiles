{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  imports = [
    ./boot.nix
    ./gitops.nix
    ./nixconf.nix
    ./secrets.nix
    ./users.nix
  ];

  config = {
    hardware.enableAllFirmware = true;

    console = {
      keyMap = "us";
      packages = with pkgs; [
        terminus_font
      ];
      font = "Lat2-Terminus16";
    };

    i18n.defaultLocale = "en_US.UTF-8";

    programs = {
      nix-ld.enable = true;
      nh = {
        enable = true;

        clean = {
          enable = true;
          dates = "daily";
          extraArgs = "--keep-since 3d --keep 5";
        };
      };
    };

    system.stateVersion = config.system.nixos.release;
  };
}
