
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


    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 1000;
      save = 1000;
    };

    initContent = ''
      export ZSH_THEME="bira"
      setopt autocd extendedglob nomatch notify
      unsetopt beep

      bindkey -e

      alias enix="sudo nano /etc/nixos/configuration.nix"
      alias unix="sudo nixos-rebuild switch"
    '';
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

    # ZSH enhancements previously managed by oh-my-zsh
    zsh-git-prompt
    zsh-nix-shell
    zsh-completions
    zsh-command-time
    zsh-fast-syntax-highlighting
    nix-zsh-completions
  ];
}
