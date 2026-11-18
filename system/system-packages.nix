{ lib, config, pkgs, ... }:

# Anything that could be remotely be considered changeable goes here.

{
  # User Account
  users.users.merfoo = {
    isNormalUser = true;
    description = "merfoo";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "merfoo"; # Make sure to change via passwd
    shell = pkgs.fish;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    git
    tmux
    helix
  ];
  
  programs.fish.enable = true;

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.sway = {
    enable = true;
    package = null;
  };
}
