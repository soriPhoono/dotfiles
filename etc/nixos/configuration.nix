{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enabled = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    cleanTmpDir = true;
  };

  networking = {
    hostName = "home-server";
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 22 ];
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Chicago";

  programs = {
    zsh.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    tree
    curl
    git
    gnupg
    neovim
    tmux
    gnumake
    unzip
  ];

  services.openssh.enable = true;

  system.stateVersion = "23.05";
}
