[
  (self: super: {
    vscode = super.vscode.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
          sha256 = "0k1sh8v3fnfpdc16y0ci00c7y9fadkr1sy676l3wgy3jhwbihwr2";
        };
      }
    );
  }) # vscode update system
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
  (self: super: {
    path-of-building = super.path-of-building.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://github.com/PathOfBuildingCommunity/PathOfBuilding/archive/refs/tags/v2.42.0.tar.gz";
          sha256 = "";
        };
      }
    );
  })
  (final: prev: {
    nerdfonts = prev.nerdfonts.override {
      fonts = [
        "AurulentSansMono"
        "JetBrainsMono"
      ];
    };
  }) # Selected nerd fonts to install
]
