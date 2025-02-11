{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.system;
in {
  options.system = {
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
      users = lib.genAttrs cfg.users (user: {
        inherit (cfg) shell;

        hashedPasswordFile = lib.mkIf config.system.secrets.enable config.sops.secrets."${user}/password".path;
      });
    };

    programs = {
      dconf.enable = true;
      fish.enable = cfg.shell == pkgs.fish;
    };
  };
}
