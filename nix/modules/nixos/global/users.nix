{ lib, pkgs, config, ... }:
let cfg = config.global.users;
in {
  options.global.users =
  {
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of users to create";

      default = [
        "soriphoono"
      ];
    };

    shell = lib.mkOption{
      type = lib.types.package;
      description = "Default shell for users";
      default = pkgs.fish;
    };
  };

  config = {
    programs = {
      dconf.enable = true;

      fish.enable = lib.mkIf (cfg.shell == pkgs.fish) true;
      zsh.enable = lib.mkIf (cfg.shell == pkgs.zsh) true;
    };

    snowfallorg.users = lib.genAttrs
      cfg.users
      (name: {
        create = true;
        admin = true;

        home.enable = true;
      });

    users.users = lib.genAttrs
      cfg.users
      (name: {
        shell = cfg.shell;
      });
  };
}
