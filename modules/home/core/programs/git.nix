{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.git;
in {
  options.core.programs.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "The git username to set globally for the profile";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The git email to set globally for the profile";
    };
  };

  config = {
    programs.git = {
      inherit (cfg) userName userEmail;

      enable = true;

      aliases = {
        edit = "commit --amend --only";
      };

      ignores = [
        "*.bak"
      ];

      signing = {
        format = "openpgp";
      };

      extraConfig = {
        init.defaultBranch = "main";

        diff.algorithm = "histogram";

        help.autocorrect = "prompt";

        commit.verbose = true;
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        pull.rebase = true;
        rebase.autosquash = true;
        rerere.enabled = true;

        merge.conflictStyle = "zdiff3";

        url = {
          "git@github.com:" = {
            insteadOf = "github:";
          };
        };
      };

      delta = {
        enable = true;

        options = {
          line-numbers = true;
          side-by-side = true;
        };
      };
    };
  };
}
