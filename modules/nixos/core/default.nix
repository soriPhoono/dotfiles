{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./nixconf.nix
    ./secrets.nix
    ./users.nix
  ];

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
        extraArgs = "--keep-since 5d";
      };
    };
  };

  system.stateVersion = config.system.nixos.release;
}
