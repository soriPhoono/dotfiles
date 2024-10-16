{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs;
      [ "${lxqt.lxqt-policykit}/bin/lxqt-policykit-agent" ];

    exec = with pkgs; [
      "sleep 1 && ${ags}/bin/ags -q && ${ags}/bin/ags"
    ];
  };
}
