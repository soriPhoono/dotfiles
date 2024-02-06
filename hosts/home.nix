{ pkgs, user, ... }: {
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      eza # Install the eza ls replacement
      bat # Install the bat cat replacement
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
      jq # Install the jq package
    ];

    stateVersion = "23.11";
  };

  programs = {


    home-manager.enable = true;
  };
}
