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
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable user applications for end-user systems";
  };

  config = lib.mkIf cfg.enable {
    # Look into LMMS
    home.packages = with pkgs; [
      thunderbird
      signal-desktop
      element-desktop

      gimp
      obs-studio
      tenacity

      discord
      betterdiscordctl
    ];
  };
}
