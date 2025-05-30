
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
#  programs.btop.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Shell utilities
  home.packages = with pkgs; [
    nh
    kdePackages.kcalc
    firefox
    kdePackages.kate
    discord
    kdePackages.yakuake
    google-chrome
    signal-desktop-bin
    git
    htop
    element-desktop
    cups-brother-hl1210w
    nextcloud-client
    libreoffice
    tlp
    yubico-pam
    nheko
    cmatrix
    spice
    spice-gtk
    moonlight-qt
    p7zip
    vscode
    warp-terminal
    android-tools
    android-udev-rules
    btop-rocm
    lutris
    openshift
    kubernetes
    kubernetes-helm
    jmeter
    krita
    openssl
    zlib
    libffi
    gmp
    slack
    nixpkgs-review
    gh
    vlc
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    winetricks

    # ZSH enhancements previously managed by oh-my-zsh
    zsh-git-prompt
    zsh-nix-shell
    zsh-completions
    zsh-command-time
    zsh-fast-syntax-highlighting
    nix-zsh-completions
  ];
}
