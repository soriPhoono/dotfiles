{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Import the rest of the configuration.
    ./modules/boot.nix
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

      config = {
        userName = "soriphoono";
        userEmail = "soriphoono@gmail.com";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.ntfs3g
  ];

  # Enable automatic updates and set the reboot window.
  system = {
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
