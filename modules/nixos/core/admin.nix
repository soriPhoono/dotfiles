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

        ${cfg.name} = {
          isNormalUser = true;

          name = cfg.name;
          description = lib.soriphoono.real_to_unix_name cfg.name;

          initialPassword = "hello";

          home = "/home/${cfg.name}";
          group = "users";

          extraGroups = [ "wheel" ];
        };
      };
    };
  };
}
