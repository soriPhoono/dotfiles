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
          "org.kde.plasma.networkmanagement"
          "org.kde.plasma.bluetooth"
          "org.kde.plasma.battery"
          "org.kde.plasma.digitalclock"
        ];
      }
      {
        location = "bottom";
        lengthMode = "fit";
        height = 35;
        floating = true;
        alignment = "center";
        hiding = "dodgewindows";

        widgets = [
          "org.kde.plasma.appmenu"
          "org.kde.plasma.taskmanager"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };
}
