{ config, lib, pkgs, username, hostname, ... }:
{
  imports = [
    ./nixpkgs.nix

    ./locale.nix

    ./users.nix
  ];

  documentation = {
    enable = lib.mkDefault true;
    man.enable = lib.mkDefault true;
    info.enable = lib.mkDefault true;
    nixos.enable = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  networking.hostName = "${hostname}";

  programs.command-not-found.enable = true;

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "soriphoono ${config.networking.hostName}";

        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = lib.mkDefault "24.11";
}
