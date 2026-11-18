{ config, pkgs, ... }:

{

  # Keep TTY1 as a login/recovery terminal
  systemd.services."kmsconvt@tty1".enable = false;
  systemd.services."getty@tty1" = {
    enable = true;
    wantedBy = [ "getty.target" ];
  };

  # Using kmscon for tty2 through tty6
  services.kmscon = {
    enable = true;
    hwRender = true;       # Use GPU acceleration (OpenGL ES / Mesa)
    useXkbConfig = true;   # Inherit keyboard layouts from services.xserver.xkb
    fonts = [
      {
        name = "BigBlueTermPlus Nerd Font";
        package = pkgs.nerd-fonts.bigblue-terminal;
      }
    ];
    extraConfig = ''
      font-size=14
      palette=solarized
      sb-size=10000
    '';
  };

  systemd.services.switch-to-tty2 = {
    description = "Switch to TTY2 after boot finishes";
    after = [ "getty.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      type = "OneShot";
      ExecStart = "${pkgs.kbd}/bin/chvt 2";
    };
  };
}
