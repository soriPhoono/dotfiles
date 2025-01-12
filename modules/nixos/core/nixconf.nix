{ lib, config, ... }:
let
  this = "core.nixconf";

  cfg = config."${this}";
in
{

  options."${this}" = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Configure nixconf to automatically clean the package registry on boot";

      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    warnings = [ ];

    nix = {
      settings.experimental-features = [ "flakes" "nix-command" ];

      optimise = {
        dates = lib.mkDefault [ "daily" ];

        automatic = lib.mkDefault true;
      };

      gc = {
        automatic = lib.mkDefault true;

        dates = lib.mkDefault "daily";

        options = lib.mkDefault "--delete-older-than 1d";
      };
    };

    nixpkgs.config.allowUnfree = lib.mkDefault true;
  };
}
