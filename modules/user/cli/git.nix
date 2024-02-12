{ username, ... }: {
  programs = {
    git = {
      enable = true;

      userName = "${username}";
      userEmail = "${username}@gmail.com";

      delta = {
        enable = true;

        options = {
          features = "decorations";

          true-color = "always";
          whitespace-error-style = "22 reverse";

          line-numbers = true;

          side-by-side = true;
          line-numbers-left-format = "";
          line-numbers-right-format = "| ";

          hyperlinks = true;
          hyperlinks-file-link-format = "vscode://file/{path}:{line}"; # TODO: possible bad code

          merge = {
            conflictstyle = "diff3";
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
