{ config, pkgs, ... }:

# I only put really basic stuff in here.
# Even system-wide packages are in another file.

{
  imports = [
    ./hardware-configuration.nix
    ./system-goods.nix
  ];

  # Bootloader -- UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables

  # Networking
  networking.hostName = "nixos";
  i18n.defaultLocale = "en_US.UTF-8";

  # VirtualBox Integration
  virtualisation.virtualBox.guest.enable = true;

  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Audio -- Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  }; 

  # Nix stuff
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; # "You gotta use Flakes, bro!" -me
      auto-optimise-store = true;
    };
    gc = { # Keep a nice and clean store, no?
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Automatic Btrfs scrubbing. Make it scrub until it can see its reflection every month.
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  system.stateVersion = "24.11";
}
