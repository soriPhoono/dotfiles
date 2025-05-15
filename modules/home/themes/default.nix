{pkgs, ...}: {
  imports = [
    ./catppuccin.nix
  ];

  stylix = {
    enable = true;

    image = ../../../assets/image.png;

    cursor = {
      package = pkgs.bibata-cursors;
      size = 24;
      name = "Bibata-Modern-Ice";
    };

    iconTheme = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.aurulent-sans-mono;
        name = "AurulentSansM Nerd Font Propo";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.aurulent-sans-mono;
        name = "AurulentSansM Nerd Font Propo";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      sizes = let
        default = 14;
      in {
        applications = default;
        desktop = default;
        popups = default;
        terminal = default;
      };
    };
  };
}
