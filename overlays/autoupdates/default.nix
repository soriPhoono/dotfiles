{inputs, ...}: final: prev: {
  discord = prev.discord.overrideAttrs (
    _: {src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";}
  );

  neovim = inputs.nvim.packages.x86_64-linux.hollace;
}
