{ pkgs, alacrittyConfig ? "", ... }:
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
    ".config/alacritty/alacritty.yml".text = alacrittyConfig.text;
  };
}
