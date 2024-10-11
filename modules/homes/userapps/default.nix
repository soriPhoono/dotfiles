{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [ ./office.nix ./development.nix ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      discord
      signal-desktop
    ];
  };
}
