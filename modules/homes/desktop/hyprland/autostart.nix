{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs;
      [
        "${lxqt.lxqt-policykit}/bin/lxqt-policykit-agent"
        "${ags}/bin/ags"
      ];

    exec = with pkgs; [
      "${ags}/bin/ags -q && ${ags}/bin/ags"
    ];
  };
}
