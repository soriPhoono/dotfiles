{ lib, pkgs, ... }: {
  imports = [
    ./users.nix
    ./nixconf.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = lib.mkDefault "America/Chicago";

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  system.stateVersion = lib.mkDefault "25.05";
}
