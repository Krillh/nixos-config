{ config, pkgs, ... }:

{

  home.packages = with pkgs; [ ];

  # Cross-platform Password Manager
  programs.keepassxc = {
    enable = true;
    settings.General = {
      LastDir = "${config.home.homeDirectory}/passwords";
      OpenPreviousDatabasesOnStartup = true;
      LastOpenedDatabases = "${config.home.homeDirectory}/passwords/vault.kdbx";

      AutoSaveAfterEveryChange = true;
      AutoReloadOnChange = true;
      UseAtomicSaves = true;
    };
  };

  # Cross-platform File Sharing (crucially, including passwords)
  services.syncthing = {
    enable = false;
    # ? may want to move to another .nix file later since it's not just for KeePassXC

    # Maintains this config as the single source of truth.
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices."android-phone".id = ""; # TODO: set up syncthing on android

      folders = {
        "passwords" = { # Sync ~/passwords folder with the KeePassXC database
          path = "${config.home.homeDirectory}/passwords";
          devices = [ "android-phone" ];
          versioning.type = "simple";
          versioning.params.keep = "5";
        };

        "notes" = { # not 100% what this folder will be used for exactly yet :P
          path = "${config.home.homeDirectory}/docs/notes";
          devices = [ "android-phone" ];
        };
      };
    };
  };
}
