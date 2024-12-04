{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = { };

    settings = {
      editor = {
        cursor-shape = {
          normal = "bar";
          insert = "bar";
          select = "bar";
        };
      };
      keys = {
        normal = {
          space.w = ":w";
          space.q = ":q";
        };
      };
    };
  };
}
