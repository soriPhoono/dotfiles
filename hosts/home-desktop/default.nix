{ lib, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    
    ../../modules/core
  ];

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
    rtkit.enable = true;

    polkit = {
      enable = true;
    };
  };

  systemd.tmpfiles.rules = 
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
    
    systemPackages = with pkgs; [
      polkit_gnome
    ];
  };

  programs = {
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

  system.stateVersion = lib.mkDefault "24.11";
}
