{ pkgs
, username
, ...
}: {
  programs.zsh.enable = true;

  users.users.${username} = {
    name = "${username}";

    isNormalUser = true;

    shell = pkgs.zsh;
  };
}
