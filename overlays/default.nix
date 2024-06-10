[
/*
  (final: prev: {
    vscode = prev.vscode.override {
      _ = {
        src = fetchTarball "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
      };
    };
  })
*/
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
