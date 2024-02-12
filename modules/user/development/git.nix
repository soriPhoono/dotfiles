{ username, ... }: {
  programs = {
    git = {
      enable = true;

      userName = "${username}";
      userEmail = "${username}@gmail.com";

      delta = {
        enable = true;

        options = {
          side-by-side = true;

          hyperlinks = true;
          hyperlinks-file-link-format = "vscode://file/{path}:{line}"; # TODO: possible bad code

          colorMoved = "default";

          features = "unobtrusive-line-numbers decorations";

          unobtrusive-line-numbers = {
            line-numbers = true;
            line-numbers-minus-style = "#444444";
            line-numbers-zero-style = "#444444";
            line-numbers-plus-style = "#444444";
            line-numbers-left-format = "{nm:>4}┊";
            line-numbers-right-format = "{np:>4}│";
            line-numbers-left-style = "blue";
            line-numbers-right-style = "blue";
          };

          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow ul";
            file-decoration-style = "none";
            hunk-header-decoration-style = "yellow box";
          };
        };
      };
    };
  };
}
