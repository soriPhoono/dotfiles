{
  programs.nixvim =
    {
      enable = true;
      defaultEditor = true;
      nixpkgs.useGlobalPackages = true;
    }
    // (import ../../nvim/default);
}
