{
  ...
}: self: super: {
    discord = super.discord.overrideAttrs (
      _: {
        src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "1mmyxjvwfp8fx89wb02k0rn24pnp2ifj5q4m38m9z919yphahafi";
        };
      }
    );
  }
