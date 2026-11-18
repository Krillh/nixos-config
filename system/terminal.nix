{ lib, config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.bigblue-terminal
  ];

    # ---- Keep TTY1 as a login/recovery terminal ---- # (AI-generated because I don't get it yet ;n;)
  # Restore the normal getty template suppressed by Kmscon.
  systemd.suppressedSystemUnits = lib.mkForce [ ];
  # Let Kmscon own automatic console activation on the other TTYs.
  systemd.services."getty@".aliases = lib.mkForce [ ];
  # Disable Kmscon specifically on TTY1.
  systemd.services."kmsconvt@tty1".enable = false;
  # Apply these settings to the existing normal-login template.
  systemd.services."getty@tty1" = {
    enable = true;
    overrideStrategy = "asDropin";
    wantedBy = [ "getty.target" ];
  };
  # Start the normal TTY1 login instead of the default Kmscon TTY1.
  systemd.targets.getty.wants = lib.mkForce [
    "getty@tty1.service"
  ];

  # Using kmscon for tty2 through tty6
  services.kmscon = {
    enable = true;
    useXkbConfig = true;   # Inherit keyboard layouts from services.xserver.xkb

    config = {
      font-name = "BigBlueTermPlus Nerd Font";
      font-size = "14";
      palette = "solarized";
      sb-size = "10000";
      hwaccel = true;
    };
  };

  systemd.services.switch-to-tty2 = {
    description = "Switch to TTY2 after boot finishes";
    after = [ "getty.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kbd}/bin/chvt 2";
    };
  };
}
