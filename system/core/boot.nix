{ config, pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%"; # 50% of RAM
      cleanOnBoot = true;
    };

    plymouth = {
      enable = true;

      themePackages = with pkgs; [
        (catppuccin-plymouth.override { variant = "mocha"; })
      ];

      theme = "catppuccin-macchiato";
    };
  };

  zramSwap.enable = true;
}
