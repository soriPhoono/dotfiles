{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.programs.git;
in {
  options.core.programs.git = {
    enable = lib.mkEnableOption "Enable git config";

    username = lib.mkOption {
      type = lib.types.str;
      description = "Your username for git related services";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Your email for git related inquiry";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      userName = cfg.username;
      userEmail = cfg.email;

      aliases = {
        edit = "commit --amend --only";
      };

      ignores = [
        "*.bak"
      ];

      extraConfig = {
        core.editor = "${pkgs.neovim}/bin/nvim";

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
