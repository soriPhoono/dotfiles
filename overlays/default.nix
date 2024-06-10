[
  (final: prev: {
    discord = prev.discord.override {
      _ = {
        src = fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";
      };
    };
  }) # Discord update system
  (final: prev: {
    nerdfonts = prev.nerdfonts.override {
      fonts = [
        "AurulentSansMono"
        "JetBrainsMono"
      ];
    };
  }) # Selected nerd fonts to install
]
