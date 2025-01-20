{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shell;
in {
  options.core.shell = {
    shell = lib.mkOption {
      type = lib.types.enum ["bash" "fish"];
      description = "The package to use as the default user shell";

      default = "fish";
    };
  };

  config = {
    users.defaultUserShell =
      if cfg.shell == "fish"
      then pkgs.fish
      else pkgs.bashInteractive;

    programs = {
      dconf.enable = true;

      fish = {
        enable = cfg.shell == "fish";

        shellAliases.rebuild = let
          rebuild = pkgs.writeShellApplication {
            name = "rebuild.sh";

            text = ''
              echo "WIP..."
            '';
          };
        in "${rebuild}/bin/rebuild.sh";
      };
    };
  };
}
