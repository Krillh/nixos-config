{ pkgs, ... }:
# Basically this whole file will be for the neovim config lol
{
  
  home.packages = with pkgs; [
    helix
  ];

  programs.neovim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Will have to be discovered

      # TODO: rust support: +rust-analyzer
      # TODO: obsidian support: +link support  +file tree  +good rendering
    ];
  };
}
