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

    firewall.allowedTCPPorts = [ 80 443 22 ];
  };

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  time.timeZone = "America/Chicago";

  programs = {
    zsh = {
      enable = true;
      interactiveShellInit =
        "alias du=\"dua i\"
alias df=\"duf\"
alias ls=\"exa -al --color=auto --icons --group-directories-first --git\"
alias tree=\"tre -al 4 -c automatic\"
alias cat=\"bat --theme Catppuccin-mocha --color auto\"
alias radeontop=\"radeontop -c -T\"
alias clock=\"scc\"
alias compare=\"diff --color=always '$@' | diff-so-fancy\"

neofetch";
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
      settings = {
        add_newline = true;

        format = "$directory $character";

        right_format = "$all";

        command_timeout = 1000;

        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[](bold red)";
        };

        hostname = {
          ssh_symbol = " ";
        };

        git_branch = {
          symbol = " ";
          truncation_length = 4;
          truncation_symbol = "…";
          style = "bold white";
        };

        memory_usage = {
          symbol = "󰍛 ";
        };

        directory = {
          read_only = " 󰌾";
          truncation_length = 8;
          truncation_symbol = "…";
        };

        c =
          { symbol = " "; };

        golang =
          { symbol = " "; };

        java =
          { symbol = " "; };

        lua =
          { symbol = " "; };

        meson =
          { symbol = "󰔷 "; };

        nix_shell =
          { symbol = " "; };

        nodejs =
          { symbol = " "; };

        package =
          { symbol = "󰏗 "; };

        python =
          { symbol = " "; };

        ruby =
          { symbol = " "; };

        rust =
          { symbol = " "; };

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
      };
    };

    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
        core = {
          editor = "nvim";
          pager = "diff-so-fancy | less --tabs=4 -RFX";
        };
        interactive = {
          diffFilter = "diff-so-fancy --patch";
        };
      };
    };

    nix-ld.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # CLI essential tools
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
  ];

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    cockpit = {
      enable = true;
      openFirewall = false; # Set to true to open port 9090 in firewall

      settings = {
        WebService = {
          Origins = "https://admin.cryptic-coders.net";
          ProtocolHeader = "X-Forwarded-Proto";
          AllowUnencrypted = true;
        };
      };

      # TODO: test this
    };

    nextcloud = {
      enable = true;
      hostName = "cloud.cryptic-coders.net";
      database.createLocally = true;
      config = {
        dbtype = "pgsql";
        adminpassFile = "/var/lib/nextcloud/adminpass";
      };
    };

    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      backupDir = "/var/lib/vaultwarden/backups";
      # TODO: finish this
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      soriphoono = {
        name = "soriphoono";
        isNormalUser = true;
        initialPassword = "hello";

        extraGroups = [ "wheel" "networkmanager" ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP+NeXFiQRntORT8b4Usk+NPvZvSdftgvRMtPD9KnTmK"
        ];
      };
    };
  };

  system.stateVersion = "23.05";

  nix = {
    gc = {
      automatic = true;
      dates = "00:00";
    };
  };
}
