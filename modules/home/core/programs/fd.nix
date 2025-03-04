{
  programs.fd = {
    enable = true;
    hidden = true;

    extraOptions = [
      "--follow"
      "--color=always"
    ];

    ignores = [
      ".git"
      "*.bak"
    ];
  };
}
