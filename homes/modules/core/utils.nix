{ pkgs, ... }: {
  imports = [ ../editors/helix ../editors/neovim ];

  home = {
    packages = with pkgs; [
      # python
      python3
      python312Packages.pip
    ];

    shellAliases = with pkgs; {
      df = "${duf}/bin/duf";
      du = "${dua}/bin/dua";
    };
  };

  programs = {
    direnv = {
      enable = true;

      nix-direnv.enable = true;

      config = { };
    };
  };
}
