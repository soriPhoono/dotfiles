{ ... }: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "${../../../assets/wallpapers/1.jpg}"
      ];

      wallpaper = [
        ",${../../../assets/wallpapers/1.jpg}"
      ];
    };
  };
}
