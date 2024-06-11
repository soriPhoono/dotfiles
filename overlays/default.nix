[
  (self: super: {
    vscode = super.vscode.overrideAttrs (
      _: {
        src = builtins.fetchTarball "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
      }
    );
  }) # Discord update system
  (self: super: {
    discord = super.discord.overrideAttrs (
      _: {
        src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";
      }
    );
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
