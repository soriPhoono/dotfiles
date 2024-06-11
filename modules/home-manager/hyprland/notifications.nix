{ pkgs, ... }: {
  home.packages = with pkgs; [
    libnotify
  ];

  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };

    settings = {
      global = {
        width = 177;
        height = 100;
        notification_limit = 3;
        origin = "bottom-right";
        offset = "20x20";
        gap_size = "5";
      };
    };
  };
}
