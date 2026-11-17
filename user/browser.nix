{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qutebrowser
    ungoogled-chromium
  ];
}
