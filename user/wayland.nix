{ pkgs, ... }:

{
  imports = [
    # ./tools/screenshot.nix
  ];

  home.packages = with pkgs; [
    foot
    kitty rio # should make a choice between these
    fuzzel
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod1"; # Alt key; use Mod4 for Windows key.
      terminal = "foot";
      menu = "fuzzel";
      startup = [
        { command = "foot -e fish"; } # run on startup
      ];

      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+Shift+q+p" = "exit" # Alt + QUIT + PLEASE. lol xD
        # "${modifier}+b" = "exec chromium"
      };
    };
  };
}
