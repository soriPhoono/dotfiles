{ ... }: {
  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [
        "${../../../assets/wallpapers/1.png}"
      ];

      wallpaper = [
        ",${../../../assets/wallpapers/1.png}"
      ];
    };
  };
}