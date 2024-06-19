{ ... }: {
  programs = {
    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      includes = [
        # TODO: setup sops-nix to store school git data
      ];

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;
          hyperlinks = true;

          # TODO: add to nixpkgs the github repo open-in-editor and replace this line
          hyperlinks-file-link-format = "vscode://file/{path}:{line}";

          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };
  };
}
