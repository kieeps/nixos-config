
{ config, pkgs, ... }:

{
  home.username = "kieeps";
  home.homeDirectory = "/home/kieeps";
  home.stateVersion = "24.05";

  # ZSH shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      enix = "sudo nano /etc/nixos/configuration.nix";
      unix = "sudo nixos-rebuild switch";
    };

    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 1000;
      save = 1000;
    };

    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "z"
        "sudo"
      ];
    };
  };


  # Git and general tools
  programs.git.enable = true;
  programs.btop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Shell utilities
  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fzf
    zoxide
    eza
    bat
    home-manager

    # ZSH enhancements previously managed by oh-my-zsh
    zsh-git-prompt
    zsh-nix-shell
    zsh-completions
    zsh-command-time
    zsh-fast-syntax-highlighting
    nix-zsh-completions
  ];
}
