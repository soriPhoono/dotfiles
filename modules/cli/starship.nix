{ pkgs, ... }: {
  programs = {
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
  };
}
