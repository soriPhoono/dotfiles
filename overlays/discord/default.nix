{ ... }: self: super: {
  discord = super.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "0gn3phng4w9qrn20zx1cdxjdf6xylivacfl9m2q2677h8kplpp9j";
      };
    }
  );
}
