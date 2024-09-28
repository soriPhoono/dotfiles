{ pkgs, ... }: {
  home = {
    packages = with pkgs;
      [
        # python
        python3
      ];
  };
}
