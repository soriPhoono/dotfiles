{ pkgs, ... }: {
  boot.plymouth.enable = true;

  boot.plymouth = {
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [
          "rings"
        ];
      })
    ];

    theme = "rings";
  };
}