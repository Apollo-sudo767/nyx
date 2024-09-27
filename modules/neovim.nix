{ config, pkgs, ... };

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      nvim-surround
      nvim-lspconfig
      nvim-fzf
      dashboard-nvim
      lspsaga-nvim
      feline-nvim
      nvim-cokeline
      nerdtree
      vim-floaterm
      tokyonight-nvim
  };
