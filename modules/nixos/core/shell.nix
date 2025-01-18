{
  lib,
  pkgs,
  config,
  hostname,
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

    programs = let
      rebuild_script = pkgs.writeShellApplication {
        name = "rebuild.sh";

        runtimeInputs = with pkgs; [
          nix-index
        ];

        # TODO: check this
        text = ''
          echo "[INFO] Re-creating system configuration, would you like to power down between generations, or roll over to the next in this power cycle? [s/r]"

          nix-index
        '';
      };
    in {
      dconf.enable = true;

      fish = {
        enable = cfg.shell == "fish";

        shellAliases = {
          rebuild = "${rebuild_script}/bin/rebuild.sh";
        };
      };
    };
  };
}
