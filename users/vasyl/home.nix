{ config, pkgs, ... }:

{
  home.username = "vasyl";
  home.homeDirectory = "/home/vasyl";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    firefox
    git
    git-crypt
    gnupg
    htop
    alacritty
    spacevim
  ];
  programs.home-manager.enable = true;
  home.file = {
    ".config/alacritty/alacritty.yml".text = ''
      env:
        TERM: xterm-256color
      cursor:
        style:
          shape: Beam
          blinking: Always
      font:
        size: 14.0
    '';
  };
}
