{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.users;
in {
  options.core.users = {
    enable =
      lib.mkEnableOption "Enable user management"
      // {
        default = true;
      };

    shell = lib.mkOption {
      type = lib.types.package;
      description = "The package to use as the user's shell";

      default = pkgs.fish;
    };

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Users to configure for interaction";

      default = ["soriphoono"];
    };
  };

  config = {
    snowfallorg.users = lib.genAttrs cfg.users (_: {});

    users = {
      users = lib.genAttrs cfg.users (_: {
        inherit (cfg) shell;

        initialPassword = "password";
      });
    };

    programs = {
      dconf.enable = true;

      fish.enable = cfg.shell == pkgs.fish;
    };
  };
}
