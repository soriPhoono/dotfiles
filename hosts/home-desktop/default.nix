{ lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  documentation.dev.enable = true;

  boot = {
    initrd.supportedFilesystems = [ "ext4" "vfat" "ntfs" "exfat" ];

    kernelPackages = pkgs.linuxPackages_zen;
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

    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl

        intel-compute-runtime
        rocmPackages.clr.icd
      ];
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;

    rtkit.enable = true;

    polkit = {
      enable = true;
    };
  };

  systemd.tmpfiles.rules = 
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];

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

  users.users = {
    soriphoono = {
      description = "Sori Phoono";

      isNormalUser = true;
      shell = pkgs.fish;
      
      extraGroups = [ "wheel" "networkmanager" "audio" ];
    };
  };

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
    
    systemPackages = with pkgs; [
      coreutils

      wget

      polkit_gnome
    ];
  };

  programs = {
    fish.enable = true;

    gnome-disks.enable = true;
    partition-manager.enable = true;

    file-roller.enable = true;

    seahorse.enable = true;
    nautilus-open-any-terminal = {
      enable = true;

      terminal = "alacritty";
    };
  };

  services = {
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    devmon.enable = true;

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

    gnome = {
      gnome-keyring.enable = true;

      sushi.enable = true;
    };
  };

  networking = {
    networkmanager = {
      enable = true;

      wifi.powersave = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [ "nix-command" "flakes" ];

      keep-derivations= true;
      keep-outputs = true;
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
