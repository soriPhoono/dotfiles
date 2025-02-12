{
  lib,
  pkgs,
  ...
}: {
  networking.wireless.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    nixos-facter
  ];

  core = {
    boot.enable = false;
    users.enable = false;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
