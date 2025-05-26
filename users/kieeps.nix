# users/kieeps.nix
{ config, pkgs, username, homeDirectory, hostname, ... }:

{
  home.username = "kieeps";
  home.homeDirectory = "/home/kieeps";
  home.stateVersion = "24.05";


  programs.git.enable = true;
  programs.btop.enable = true;

  programs.zsh = {
    enable = true;
    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 1000;
      save = 1000;
    };

    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    ohMyZsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "z"
        "sudo"
      ];
      customPkgs = with pkgs; [
        zsh-git-prompt
        zsh-nix-shell
        zsh-completions
        zsh-command-time
        zsh-fast-syntax-highlighting
        nix-zsh-completions
      ];
    };

    initExtra = ''
      setopt autocd extendedglob nomatch notify
      unsetopt beep

      bindkey -e

      alias enix="sudo nano /etc/nixos/configuration.nix"
      alias unix="sudo nixos-rebuild switch"
    '';
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fzf
    zoxide
    eza
    bat
    home-manager
  ];

  # Host-specific NH config will be in kieeps-Lappen.nix / kieeps-Supern.nix
}
