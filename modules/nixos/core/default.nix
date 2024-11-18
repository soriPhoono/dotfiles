{ lib, pkgs, ... }:
{
  imports = [ ./nixpkgs.nix ./boot.nix ./hardware.nix ./openssh.nix ./user.nix ];

  time.timeZone = lib.mkDefault "America/Chicago";

  security.sudo.wheelNeedsPassword = false;

  environment = {
    systemPackages = with pkgs; [ coreutils ];
  };

  system.stateVersion = lib.mkDefault "24.11";
}
