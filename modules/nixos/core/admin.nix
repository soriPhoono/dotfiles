{ lib, pkgs, config, ... }:
let
  this = "core.admin";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Create admin account for the system";

      default = true;
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "The admin account's username";

      default = "Sori Phoono";
    };

    unixName = lib.mkOption {
      type = lib.types.str;
      description = "The admin account's unix username";

      default = "soriphoono";
    };
  };

  config = lib.mkIf cfg.enable {
    warnings = [ ];

    programs = {
      dconf.enable = true;
      fish.enable = true;
    };

    users = {
      defaultUserShell = pkgs.fish;

      users = {
        root.shell = pkgs.bashInteractive;

        ${cfg.unixName} = {
          isNormalUser = true;

          name = cfg.unixName;
          description = cfg.name;

          initialPassword = "hello";

          home = "/home/${cfg.unixName}";
          group = "users";

          extraGroups = [ "wheel" ];
        };
      };
    };
  };
}
