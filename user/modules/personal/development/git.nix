{ vars, ... }:
let
  user = "${vars.user}";
in {
  programs = {
    git = {
      enable = true;

      userName = "${user}";
      userEmail = "${user}@gmail.com";

      diff-so-fancy = {
        enable = true;
      };
    };
  };
}
