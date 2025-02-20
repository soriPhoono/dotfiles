{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./development.nix

    ./programs/thunderbird.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable user applications for end-user systems";
  };

  config = lib.mkIf cfg.enable {
    # Look into LMMS
    home.packages = with pkgs; [
      discord
      signal-desktop

      onlyoffice-desktopeditors
      joplin-desktop
    ];

    userapps.programs = {
      thunderbird.enable = true;
    };
  };
}
