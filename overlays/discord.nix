final: prev: {
  discord = prev.discord.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      sha256 = "1vqm2d8j4pjn42darjpvfs6f81rias8d7rp9dw274ih78c5a9840";
    };
  });
}
