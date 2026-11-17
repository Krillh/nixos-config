{ lib, config, pkgs, ... }:

# Anything that could be remotely be considered changeable goes here.

{
  # User Account
  users.users.merfoo = {
    isNormalUser = true;
    description = "merfoo";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "merfoo"; # Make sure to change via passwd
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
    package = null;v
  };

  # TTY2 - TTY6 will be run through kmscon.
  # TTY1 will be default linux still.

  services.kmscon = {
    enable = true;
    config.font-name = "JetBrainsMono Nerd Font";
    extraOptions = "--term xterm-256color";
  };

  systemd.suppressedSystemUnits = lib.mkForce [ ];

  systemd.services."kmsconvt@tty1".enable = false;
  systemd.services."getty@tty1" = {
    enable = true;
    wantedBy = [ "getty.target" ];
  };

  systemd.services."getty@tty2".enable = false;
  systemd.services."getty@tty3".enable = false;
  systemd.services."getty@tty4".enable = false;
  systemd.services."getty@tty5".enable = false;
  systemd.services."getty@tty6".enable = false;
}
