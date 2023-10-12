{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };

  networking = {
    hostName = "home-server";
    networkmanager.enable = true;
  };

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  time.timeZone = "America/Chicago";

  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "history-substring-search"
        ];
      };
    };

    starship = {
      enable = true;
      interactiveOnly = true;
      settings = "$directory $character";
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    dosfstools
    exfatprogs
    nano
    vim
    neovim
    tmux
    zsh-history-substring-search
    neofetch
    curl
    less
    exa
    bat
    diff-so-fancy
    dua
    duf
    tre-command
    scc
    btop
    git
  ];

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      soriphoono = {
        name = "soriphoono";
        isNormalUser = true;
        initialPassword = "hello";

        extraGroups = [ "wheel" "networkmanager" ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRfXx+lW++zsz0h3u4heErHHwnagg8/Y2abeKCEDRxn"
        ];
      };
    };
  };

  system.stateVersion = "23.05";
}
