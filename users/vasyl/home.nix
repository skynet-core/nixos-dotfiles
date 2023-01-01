{ pkgs, nixpkgs-unstable, alacrittyConfig ? "", ... }:
{
  home.username = "vasyl";
  home.homeDirectory = "/home/vasyl";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    firefox
    jq
    unzip
    git-crypt
    gnupg
    htop
    alacritty
    vim
    nixfmt
    rnix-lsp
    spacevim
    vscode-fhs
  ];
  programs.autojump.enable = true;
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
  programs.zsh = {
    enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      sessionVariables = {
        EDITOR = "spcevim";
      };
      initExtra = ''
        eval "$(direnv hook zsh)"
        '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "autojump" ];
        extraConfig = "";
      };
  };
  programs.fish = {
    enable = true;
    plugins = [];
  };
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    configFile = {
        text = ''
let-env STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "
let-env config = {
 show_banner: false
}
        '';
    };
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  fonts.fontconfig.enable = true;
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "Skynet Core";
    userEmail = "skynet.vasyl@gmail.com";
  };
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
