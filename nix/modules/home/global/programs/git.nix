{ lib, config, ... }:
let cfg = config.global.git; in {
  options.global.git = {
    userName = lib.mkOption {
      type = lib.types.str;
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    programs.git = {
      inherit (cfg) userName userEmail;

      enable = true;

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com:" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        pull.rebase = true;
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;

          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };
  };
}
