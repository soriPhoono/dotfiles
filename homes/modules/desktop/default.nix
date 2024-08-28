{ pkgs
, ...
}: {
  imports = [
    ./alacritty.nix

    ./firefox.nix
  ];

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;

    platformTheme.name = "gtk";
  };
}
