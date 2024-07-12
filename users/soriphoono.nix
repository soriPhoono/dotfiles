{ lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      dua
      duf

      imagemagick

      unzip
      unrar
      p7zip
  
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

    desktopEntries = {
      google-calendar = {
        name = "Google Calendar";
        genericName = "Calendar";

        exec = "firefox https://calendar.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
        mimeType = [ "text/calendar" ];
      };
      google-drive = {
        name = "Google Drive";
        genericName = "Cloud storage";

        exec = "firefox https://drive.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
        mimeType = [ "text/pdf" "application/vnd.google-apps.file" ];
      };
      gmail = {
        name = "Gmail";
        genericName = "Email client";

        exec = "firefox https://mail.google.com/";
        terminal = false;
        categories = [ "Application" "Network" "Email" ];
        mimeType = [ "message/rfc822" ];
      };
      google-docs = {
        name = "Google Docs";
        genericName = "Document editor";

        exec = "firefox https://docs.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ];
      };
      google-slides = {
        name = "Google Slides";
        genericName = "Presentation editor";

        exec = "firefox https://slides.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        ];
      };
      google-sheets = {
        name = "Google Sheets";
        genericName = "Spreadsheet editor";

        exec = "firefox https://sheets.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
        mimeType = [
          "text/pdf"
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ];
      };
      google-tasks = {
        name = "Google Tasks";
        genericName = "Task manager";

        exec = "firefox https://tasks.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
      };
      google-keep = {
        name = "Google Keep";
        genericName = "Note-taking app";

        exec = "firefox https://keep.google.com/";
        terminal = false;
        categories = [ "Application" "Office" ];
      };
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
