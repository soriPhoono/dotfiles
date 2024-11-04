{ lib, pkgs, config, ... }:
let
  cfg = config.core;
in
{
  imports = [ ./hardware ./nixpkgs.nix ./boot.nix ./openssh.nix ./users.nix ];

  options = {
    core = {
      timeZone = lib.mkOption {
        type = lib.types.str;
        default = "America/Chicago";
        description = "Time zone";
      };

      environmentVariables = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
      };
    };
  };

  config = {
    time.timeZone = cfg.timeZone;

    environment = {
      systemPackages = with pkgs; [ coreutils ];
      sessionVariables = cfg.environmentVariables;
    };

    system.stateVersion = lib.mkDefault "24.11";
  };
}
