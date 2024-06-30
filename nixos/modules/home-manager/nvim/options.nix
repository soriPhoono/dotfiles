{
  programs.nixvim.opts = {
    updatetime = 100;

    relativenumber = false;
    number = true;
    hidden = true;

    mouse = "a";
    mousemodel = "extend";

    splitbelow = true;
    splitright = true;

    swapfile = false;
    modeline = true;
    modelines = 100;

    undofile = true;

    incsearch = true;
    inccommand = "split";

    ignorecase = true;
    smartcase = true;

    scrolloff = 8;

    cursorline = false;
    cursorcolumn = false;
    signcolumn = "yes";
    colorcolumn = "100";

    laststatus = 3;
    fileencoding = "utf-8";
    termguicolors = true;
    spell = false;

    wrap = false;

    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;

    textwidth = 0;

    foldlevel = 99;

    completeopt = [ "menu" "menuone" "noselect" ];
  };
}
