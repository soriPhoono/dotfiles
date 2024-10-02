{ lib, pkgs, ... }: {
  imports = [ ./hardware ./nixpkgs.nix ./openssh.nix ./users.nix ];

  time.timeZone = lib.mkDefault "America/Chicago";

  environment.systemPackages = with pkgs; [ coreutils ];

  system.stateVersion = lib.mkDefault "24.11";
}
