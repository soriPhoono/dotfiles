{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "tcp_bbr"
    ];
    kernelParams = [
      "i915.force_probe=a780"
    ];

    plymouth = {
      enable = true;

      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "rings"
          ];
        })
      ];

      theme = "rings";
    };

    tmp.cleanOnBoot = true;
  };

  zramSwap.enable = true;
}
