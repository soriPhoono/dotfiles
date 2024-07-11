{ lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  documentation.dev.enable = true;

  boot = {
    initrd.supportedFilesystems = [ "ext4" "vfat" "ntfs" "exfat" ];

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_brr" ];

    consoleLogLevel = 3;
    kernelParams = [ "quiet" "systemd.show_status=auto" "rd.udev.log_level=3" ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    plymouth = {
      enable = true;

      themePackages = with pkgs;
        [
          (adi1090x-plymouth-themes.override { selected_themes = [ "rings" ]; })
        ];

      theme = "rings";
    };

    tmp.cleanOnBoot = true;
  };

  zramSwap.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;

          Enable = "Source,Sink,Media,Socket";
        };
      };
    };

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    steam-hardware.enable = true;
    xone.enable = true;
    uinput.enable = true;
  };

  security = {
    sudo.wheelNeedsPassword = false;

    rtkit.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  time.timeZone = lib.mkDefault "America/Chicago";

  users = {
    defaultUserShell = pkgs.fish;

    users = {
      soriphoono = {
        description = "SoriPhoono";
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "audio" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  programs = {
    fish.enable = true;

    steam = {
      enable = true;

      protontricks.enable = true;

      remotePlay = { openFirewall = true; };

      extest.enable = true;
    };
  };

  services = {
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    pipewire = {
      enable = true;

      pulse.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      jack.enable = true;

      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };

    openssh = {
      enable = true;

      hostKeys = [{
        comment = "soriphoono zephyrus g14";

        path = "/etc/shh/ssh_host_ed25519_key";
        type = "ed25519";
      }];

      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

  };

  networking = {
    networkmanager = {
      enable = true;

      wifi = { powersave = false; };
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];
    };

    optimise = {
      dates = [ "daily" ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };

  system.stateVersion = lib.mkDefault "24.11";
}
