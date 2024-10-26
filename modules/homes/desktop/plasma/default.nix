{
  programs.plasma = {
    enable = true;

    panels = [
      {
        location = "top";
        lengthMode = "fill";
        height = 35;
        floating = true;
        alignment = "left";

        widgets = [
          "org.kde.plasma.systemmonitor.cpu"
          "org.kde.plasma.systemmonitor.memory"
          "org.kde.plasma.systemmonitor.diskusage"
          "org.kde.plasma.systemmonitor.net"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.notifications"
          "org.kde.plasma.volume"
        ];
      }
    ];
  };
}
