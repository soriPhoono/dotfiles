{config, ...}: {
  programs.git = {
    enable = true;

    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";

    signing = {
      format = "ssh";
      signByDefault = true;
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
}
