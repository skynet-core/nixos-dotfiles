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
    vim
    spacevim
  ];
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };
  nixpkgs.config.allowUnfree = true;
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
      slection:
        semantic_escape_chars: ",│`|:\"' ()[]{}<>\t"
        save_to_clipboard: true
    '';
  };
}
