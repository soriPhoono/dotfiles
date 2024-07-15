{ pkgs, ... }: {
  home.shellAliases = with pkgs; {
    ls = "eza";
    ll = "eza -l";
    lt = "eza -T";

    cat = "bat";

    df = "${duf}/bin/duf";
    du = "${dua}/bin/dua i";
  };

  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting

        fastfetch
      '';
    };

    fastfetch = {
      enable = true;
    };
  };
}
