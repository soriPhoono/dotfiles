{ lib, pkgs, config, ... }:
let
  cfg = config.core.users;

  userType = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Name of the user to create";
      };

      admin = lib.mkOption {
        type = lib.types.bool;
        description = "Create user as admin";
        default = false;
      };
    };
  };
in
{
  options.core.users = lib.mkOption {
    type = with lib.types; listOf either str userType;
    description = "List of users to create";
  };

  config = {
    programs = {
      dconf.enable = true;
      fish.enable = true;
    };

    users.defaultUserShell = pkgs.fish;

    snowfallorg.users =
      let
        genUsers = field: list: builtins.listToAttrs (map (v: { name = v.${field}; value = v; }) list);
      in
      genUsers "name" cfg;
  };
}
