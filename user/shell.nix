{ pkgs, ... }:

{
  
  home.packages = with pkgs; [
    bat
    ripgrep
    # fd
    dua
    # dust
    btop
    yazi
  ];

  # Epic rebuild script with automatic /nix and root btrfs snapshots first ^u^
  xdg.configFile."fish/functions/rebuild.fish".source = ./scripts/rebuild.fish;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  
    shellAliases = {
      cat = "bat";
      ".." = "cd ..";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;

    icons = "auto";
  };

  programs.starship = {
    enable = true;
  };
}
