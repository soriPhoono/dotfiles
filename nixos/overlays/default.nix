[
  (self: super: {
    vscode = super.vscode.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
          sha256 = "1q6ajy7kn6dxh07gcnwz5bz90sqqyy3w515g73p2vmnkr940agrq";
        };
      }
    );
  }) # vscode update system
  (self: super: {
    discord = super.discord.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "00rhcra846m6walm10y4352c3gibd4p82czsvklgafbcxs84zndq";
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
