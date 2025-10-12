{
  lib,
  config,
  ...
}: let
  cfg = config.core.git;
in {
  options.core.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      description = "The git username to use for this user";
      example = "john";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "The git email to use for this user";
      example = "john@gmail.com";
    };
  };

  config = {
    programs.git = {
      inherit (cfg) userName userEmail;

      enable = true;

      signing = {
        format = "ssh";
        key = config.core.ssh.publicKey;
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
            insteadOf = ["github:" "gh:"];
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
