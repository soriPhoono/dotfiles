{ pkgs, ... }: {
  boot = {
    loader = {
      timeout = 3;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };

    plymouth = {
      enable = true;
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-mocha";
      # TODO: Set font to SauceCodePro Nerd Font
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space
      cleanOnBoot = true;
    };
  };
}
