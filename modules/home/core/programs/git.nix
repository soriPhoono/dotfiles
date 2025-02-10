{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.git;
in {
  options.core.programs.git = {
    enable = lib.mkEnableOption "Enable git config";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      aliases = {
        edit = "commit --amend --only";
      };

      ignores = [
        "*.bak"
      ];

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
