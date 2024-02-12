{ ... }: {
  home = {
    packages = with pkgs; [
      dua # Install the dua disk usage analyzer
      duf # Install the duf disk usage finder
      tre-command # Install the tre command
      scc # Install the scc command
    ];

    shellAliases = {
      cat = "bat"; # Use bat as the replacement for cat
      du = "dua"; # Use dua as the replacement for du
      df = "duf"; # Use duf as the replacement for df
      tree = "tre"; # Use tre as the replacement for tree
      clock = "scc"; # Use scc as the replacement for clock
    };
  };

  programs = {
    eza = {
      enable = true;

      enableAliases = true;

      icons = true;
      git = true;
    };

    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        batman
      ];
    };

    jq.enable = true;
  };
}
