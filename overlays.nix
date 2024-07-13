[
  (self: super: {
    discord = super.discord.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "0k9sk5pmjw7xq68h2s80q8fg48p31albrqrqafmmrxik5f8f96rn";
        };
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
