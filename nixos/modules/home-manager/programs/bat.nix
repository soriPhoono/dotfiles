{ ... }: {
  programs = {
    bat.enable = true;
    fish.shellAliases.cat = "bat";
  };
}
