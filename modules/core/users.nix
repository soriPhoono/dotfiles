{ pkgs, username, ... }:
{
  programs.fish.enable = true;

  users.users.${username} = {
    name = "${username}";
    isNormalUser = true;
    shell = pkgs.fish;
  };
}
