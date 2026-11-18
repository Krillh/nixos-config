{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    keepassxc
  ];

  services.syncthing = {
    enable = true;

    # Maintains this config as the single source of truth.
    overrideDevices = true;
    overriceFolders = true;

    settings = {
      devices."andriod-phone".id = ""; # TODO: set up syncthing on android

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
