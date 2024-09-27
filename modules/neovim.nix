{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  
  # Optionally install additional tools used by plugins
  environment.systemPackages = with pkgs; [
    fzf  # Required by fzf-vimi
    vimPlugins.nvim-surround
    vimPlugins.fzf-vim
    vimPlugins.nvim-lspconfig
    vimPlugins.dashboard-nvim
    vimPlugins.lspsaga-nvim
    vimPlugins.feline-nvim
    vimPlugins.nvim-cokeline
    vimPlugins.nerdtree
    vimPlugins.vim-floaterm
    vimPlugins.tokyonight-nvim
  ];
}
