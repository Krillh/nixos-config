{ config, pkgs, ... }:

{
  home.username = "merfoo";
  home.homeDirectory = "home/merfoo";

  home.packages = with pkgs; [
    zoxide  # better 'cd'
    ripgrep # better 'grep'
    fd      # better 'find'
    bat     # better 'cat'

    btop    # resource monitor
    dua     # disk usage analyzer
    dust    # alternative to dua... i guess?
  ];

  # New default shell. I like fishes, you know...
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      cd = "z";
      ls = "ls --color=auto";
      .. = "cd ..";
      rebuild = "sudo nixos-rebuild switch";
    };
  };

  # Make Oxide actually work the way it should
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Enable window manager
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    extraPackages = with pkgs; [
      foot         # terminal
      wofi         # app launcher
      wl-clipboard # clipboard util
      # waybar
      # slurp, etc.
    ];
    
    config = rec {
      modifier = "Mod4"; # Windows key; use Mod1 for Alt key.
      terminal = "foot";
      menu = "wofi --show drun";
      startup = [
        { command = "foot"; } # Open foot on sway startup.
      ];

      keybinds = pkgs.lib.mkOptionsDefault {
        # "${modifier}+b" = "exec chromium";
      };
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}