{ pkgs, vars, ... }:
let
  user = "${vars.user}"; # Set the user to the user’s username.
in
{
  home-manager.users."${user}" = {
    home = {
      username = "${user}"; # Set the username to the user’s username.
      homeDirectory = "/home/${user}"; # Set the home directory to the user’s home directory.

      packages = with pkgs; [
        usbutils # Install the usbutils package
        pciutils # Install the pciutils package

        eza # Install the eza ls replacement
        bat # Install the bat cat replacement
        dua # Install the dua disk usage analyzer
        duf # Install the duf disk usage finder
        tre-command # Install the tre command
        scc # Install the scc command
        jq # Install the jq package
      ];

      stateVersion = "23.11"; # NixOS version to use.
    };

    programs = {
      zsh = {
        enable = true; # Enable zsh

        autosuggestions = {
          enable = true; # Enable zsh-autosuggestions
          strategy = [
            "history" # Use history to determine suggestions
            "completion" # Use completion to determine suggestions
            "match_prev_cmd" # Use previous command to determine suggestions
          ];
        };

        syntaxHighlighting = {
          enable = true; # Enable zsh-syntax-highlighting
          highlighters = [
            "main" # Enable main highlighter
            "brackets" # Enable bracket highlighter
            "pattern" # Enable pattern highlighter
            "cursor" # Enable cursor highlighter
            "regexp" # Enable regexp highlighter
            "root" # Enable root highlighter
            "line" # Enable line highlighter
          ];
        };

        shellAliases = {
          ls = "eza"; # Use eza as the replacement for ls
          cat = "bat"; # Use bat as the replacement for cat
          du = "dua"; # Use dua as the replacement for du
          df = "duf"; # Use duf as the replacement for df
          tree = "tre"; # Use tre as the replacement for tree
          clock = "scc"; # Use scc as the replacement for clock
        };
      };

      starship = {
        enable = true; # Enable starship

        settings = {
          add_newline = true; # Add a newline to the prompt
          format = "$directory $character"; # Minimal left prompt
          right_format = "$all"; # Remaining data on right prompt
          command_timeout = 1000; # Set the command timeout to 1000ms

          character = {
            success_symbol = "[➜](bold green)"; # Set the success symbol to a green arrow
            error_symbol = "[✗](bold red)"; # Set the error symbol to a red X
          };

          directory = {
            truncation_length = 8; # Set the truncation length to 8
            truncation_symbol = "…/"; # Set the truncation symbol to an ellipsis
          };

          git_branch = {
            truncation_length = 4; # Set the truncation length to 4
            truncation_symbol = "…"; # Set the truncation symbol to an ellipsis
          };
        };
      };

      home-manager.enable = true; # Enable home-manager.
    };
  };
}
