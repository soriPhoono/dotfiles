{
  programs.git = {
    enable = true;

    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";

    includes = [
      # TODO: setup sops-nix to store school git data
    ];

    extraConfig = {
      init.defaultBranch = "main";
      url."git@github.com/" = {insteadOf = ["gh:" "github:"];};
      pull.rebase = false;
    };

    delta = {
      enable = false;

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
