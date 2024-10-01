{ pkgs, config, ... }: {
  imports = [ ./dconf.nix ./git.nix ];

  home = with pkgs; {
    shellAliases = {
      find = "${fd}/bin/fd";
      cat = "${bat}/bin/bat";
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua";
      top = "${btop}/bin/btop";
    };

    packages = [ nh ];
  };

  programs = {
    eza = {
      enable = true;
      enableFishIntegration = true;

      extraOptions = [ "--group-directories-first" ];

      git = true;
      icons = true;
    };

    fd = {
      enable = true;
      hidden = true;

      extraOptions = [ "--follow" "--color=always" ];

      ignores = [ ".git" "*.bak" ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;

      defaultCommand = "fd --type file";
      defaultOptions = [ "--ansi" ];
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };
  };
}
