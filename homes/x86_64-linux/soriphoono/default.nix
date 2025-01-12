{ inputs, ... }: {
  imports = [
    inputs.nvim.homeModules.default
  ];

  core.git = {
    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";
  };
}
