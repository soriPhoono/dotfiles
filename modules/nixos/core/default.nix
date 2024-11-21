{ lib, pkgs, config, ... }:
let cfg = config.core;
in
{
  imports = [ ./nixpkgs.nix ./boot.nix ./hardware.nix ./openssh.nix ./user.nix ];

  options = {
    core.environment = {
      variables = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };

        description = ''
          Environment variables to set at the system level
        '';
      };

      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];

        description = ''
          Packages to install at the system level
        '';
      };
    };
  };

  config = {
    time.timeZone = lib.mkDefault "America/Chicago";

    security.sudo.wheelNeedsPassword = false;

    environment = {
      systemPackages = with pkgs; [ coreutils ] ++ cfg.environment.packages;
      variables = cfg.environment.variables;
    };

    system.stateVersion = lib.mkDefault "24.11";
  };
}
