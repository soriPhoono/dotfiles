[
  (final: prev: {
    discord = prev.discord.override {
      _ = {
        src = fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";
      };
    };
  })
  (final: prev: {
    nerdfonts = prev.nerdfonts.override {
      fonts = [
        "AurulentSansMono"
        "JetBrainsMono"
      ];
    };
  })
]
