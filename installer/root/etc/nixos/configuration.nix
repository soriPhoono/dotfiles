{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot bootloader.
  boot = {
    loader = {
      timeout = 3;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };

    plymouth = {
      enable = true;
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-mocha";
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space
      cleanOnBoot = true;
    };
  };

  zramSwap.enable = true;

  networking = {
    networkmanager.enable = true;
  };

  programs = {
    zsh = {
      enable = true;

      autosuggestions = {
        enable = true;
        strategy = [
          "history"
          "completion"
          "match_prev_cmd"
        ];
      };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "pattern"
          "cursor"
          "regexp"
          "root"
          "line"
        ];
      };
    };

    git = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.ntfs3g
  ];

  users = {
    defaultUserShell = pkgs.zsh;

    users.soriphoono = {
      name = "soriphoono";
      description = "Sori Phoono";
      password = "password";
      isNormalUser = true;

      extraGroups = [
        "networkmanager"
      ];
    };
  };

  # Enable automatic updates and set the reboot window.
  system = {
    stateVersion = "23.11";

    autoUpgrade = {
      enable = true;
      allowReboot = true;
      rebootWindow = {
        lower = "03:00";
        upper = "05:00";
      };
    };
  };
}
