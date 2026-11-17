function rebuild --description "Snapshot and then rebuild NixOS"
    mountpoint -q /.snapshots; or return 1

    set -l checkpoint /.snapshots/pre-rebuild-(date -u +%Y%m%dT%H%M%S%NZ)

    sudo mkdir -m 0700 "$checkpoint"; or return
    sudo btrfs subvolume snapshot -r / "$checkpoint/root"; or return
    sudo btrfs subvolume snapshot -r /nix "$checkpoint/nix"; or return
    sudo btrfs filesystem sync /.snapshots; or return

    nh os switch /etc/nixos -H default $argv
end