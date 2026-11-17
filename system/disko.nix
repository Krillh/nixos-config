{
  disko.devices.disk.main = {
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            # Optional encryption for a fresh install: uncomment the LUKS wrapper
            # below AND its matching closing brace after the Btrfs configuration.
            # This requires formatting the partition; it does not encrypt an
            # existing installation in place. Back up its data before formatting.
            # /boot stays unencrypted; /, /home, and /nix are inside LUKS.
            # Disko asks for a passphrase at setup and configures boot-time unlock.
            # type = "luks";
            # name = "cryptroot";
            # askPassword = true;
            # content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "@root" = {
                mountpoint = "/";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              # Keep checkpoints outside root so they survive a root restore.
              "@snapshots" = {
                mountpoint = "/.snapshots";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              # Preserve diagnostics and exclude disposable caches from root snapshots.
              "@log" = {
                mountpoint = "/var/log";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
              "@cache" = {
                mountpoint = "/var/cache";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
            # }; # End of the optional LUKS wrapper's content.
          };
        };
      };
    };
  };
}
