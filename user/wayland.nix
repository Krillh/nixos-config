{ pkgs, ... }:

{
  imports = [
    # ./tools/screenshot.nix
  ];

  home.packages = with pkgs; [
    foot
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
        # "${modifier}+b" = "exec chromium"
      };
    };
  };
}
