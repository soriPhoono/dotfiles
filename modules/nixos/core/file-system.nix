{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    glib
  ];

  programs.fish.shellAliases = {
    rm = "gio trash";
  };

  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}