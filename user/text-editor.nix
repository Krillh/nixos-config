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

      # nvim-lspconfig  # jump-to-definition, rename, hover documentation, etc.
      # blink.cmp       # completion
      # fzf-lua         # project-wide fuzzy search
      # gitsigns.nvim   # inline git cool
      # oil.nvim        # file management w/ vim motions

      # TODO: rust support: +rust-analyzer
      # TODO: obsidian support: +link support  +file tree  +good rendering
    ];
  };
}
