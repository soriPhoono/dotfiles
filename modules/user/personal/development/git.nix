{ username, ... }: {
  programs = {
    git = {
      enable = true;

      userName = "${username}";
      userEmail = "${username}@gmail.com";

      diff-so-fancy = {
        enable = true;
      };
    };
  };
}
