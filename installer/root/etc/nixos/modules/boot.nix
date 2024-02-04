{ pkgs, ... }: {
  # Use the systemd-boot bootloader.
  boot = {
    loader = {
      timeout = 3;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };

    plymouth = {
      # TODO: reenable plymouth once the login manager is set up
      # enable = true;
      # themePackages = [ pkgs.catppuccin-plymouth ];
      # theme = "catppuccin-mocha";
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space
      cleanOnBoot = true;
    };
  };

  zramSwap.enable = true;
}
