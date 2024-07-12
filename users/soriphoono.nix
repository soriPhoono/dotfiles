{ lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      dua
      duf
  
      usbutils
      usbtop

      pciutils

      btop
      nvtopPackages.full

      libva-utils
      vdpauinfo
      clinfo
      glxinfo
      vulkan-tools
      wayland-utils

      mkdocs
      obsidian

      gcc
      gdb
      clang-tools
      lldb
      ninja
      cmake
      meson

      zig

      rustup

      jdk

      python3

      sass

      qmk
    ];

    shellAliases = {
      cat = "bat";

      df = "duf";
      du = "dua i";
    };
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;

      createDirectories = true;
    };
  };
  
  programs = {
    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      includes = [
        # TODO: setup sops-nix to store school git data
      ];

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com/" = { insteadOf = [ "gh:" "github:" ]; };
        pull.rebase = false;
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;

          # true-color = "always";
          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };
  
    fish = {
      enable = true;

      interactiveShellInit = 
      # fish
      ''
        set fish_greeting

        fastfetch
      '';
    };

    starship = {
      enable = true;

      settings = {
        add_newline = true;

        format = "$character";
        right_format = "$all";

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    fastfetch = {
      enable = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;

      extraOptions = [
        "--group-directories-first"
        "--hyperlink"
      ];

      git = true;
      icons = true;
    };

    bat.enable = true;
    ripgrep.enable = true;

    helix = {
      enable = true;
      defaultEditor = true;

      ignores = [

      ];

      settings = {
        editor = {
          auto-save = true;

          bufferline = "multiple";

          statusline = {
            left = [
              "mode"
              "version-control"
              "file-base-name"
              "file-modification-indicator"
            ];
            right = [ "diagnostics" "file-type" "position-percentage" ];

            mode = {
              normal = "󰋜";
              insert = "󰏪";
              select = "󰍉";
            };
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
    };

    alacritty = {
      enable = true;

      settings = {
        window = {
          opacity = 0.8;

          blur = true;

          decorations = "None";
          startup_mode = "Maximized";
        };

        cursor.style = "Beam";
      };
    };
  
    home-manager.enable = true;
  };

  home.stateVersion = lib.mkDefault "24.11";
}
