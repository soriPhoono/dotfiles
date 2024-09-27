{
  programs.nixvim.opts = {
    completeopt = [ "menu" "menuone" "noselect" ];
    mouse = "a";
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;

    number = true;
    relativenumber = false;

    cursorline = true;
    splitbelow = true;
    splitright = true;
    showmode = false;

    incsearch = true;
    hlsearch = true;
    ignorecase = true;
    smartcase = true;
  };
}
