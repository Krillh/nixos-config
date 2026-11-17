{ pkgs, ... }:

{
  
  home.packages = with pkgs; [
    helix
  ];

  programs.neovim = {
    enable = true;

    # Future Neovim configuration.
  };
}
