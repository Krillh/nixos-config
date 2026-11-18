{ config, pkgs, ... }:

{
  home.username = "merfoo";
  home.homeDirectory = "/home/merfoo";

  imports = [
    ./browser.nix
    ./password-manager.nix
    ./shell.nix
    ./text-editor.nix
    ./wayland.nix
  ];

  home.packages = with pkgs; [
    spotatui
  ];
  

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
