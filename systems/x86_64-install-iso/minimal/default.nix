{
  lib,
  pkgs,
  ...
}: {
  networking.wireless.enable = lib.mkForce false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7 soriphoono@gmail.com"
  ];

  environment.systemPackages = with pkgs; [
    nixos-facter
  ];

  core.users.enable = false;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
