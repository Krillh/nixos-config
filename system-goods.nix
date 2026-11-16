{ config, pkgs, ... }:

# Anything that could be remotely be considered changeable goes here.

{
  # User Account
  users.users.merfoo = {
    isNormalUser = true;
    description = "merfoo";
    extraGroups = [ "networkmanager" "wheel" ];
    initalPassword = "merfoo"; # Make sure to change via passwd
  };

  programs.fish.enable = true;

  envionment.systemPackages = with pkgs; [
    git
    tmux
    helix
  ];
}
