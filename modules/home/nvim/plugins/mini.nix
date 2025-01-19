{
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = {
          n_lines = 500;
        };

        surround = {};
      };
    };

    extraConfigLua = ''
      require('mini.statusline').section_location = function()
        return '%21:%-2v'
      end
    '';
  };
}
