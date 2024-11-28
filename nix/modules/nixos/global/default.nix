{ lib, pkgs, ... }: {
  imports = [
    ./users.nix
    ./nixpkgs.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = lib.mkDefault "America/Chicago";

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  system.stateVersion = lib.mkDefault "24.11";
}
