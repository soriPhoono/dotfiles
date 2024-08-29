{ config
, lib
, pkgs
, username
, ...
}: {
  imports = [
    ./nixpkgs.nix

    ./hardware

    ./boot.nix
    ./system-keys.nix
    ./users.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  system.stateVersion = lib.mkDefault "24.11";
}
