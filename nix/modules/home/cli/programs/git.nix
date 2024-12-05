{ ... }: {
  programs.git = {
    enable = true;

    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";

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
}
