{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./programs/thunderbird.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable user applications for end-user systems";
  };

  config = lib.mkIf cfg.enable {
    # Look into LMMS
    home.packages = with pkgs; [
      discord
      element-desktop
      signal-desktop

      gimp
      obs-studio
      tenacity
    ];

    userapps.programs = {
      thunderbird.enable = true;
    };
  };
}
