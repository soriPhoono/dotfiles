{ pkgs, ... }: {
  programs.partition-manager.enable = true;

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    konsole
    oxygen
  ];
}
