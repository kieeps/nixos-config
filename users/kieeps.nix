# users/kieeps.nix
{ config, pkgs, username, homeDirectory, hostname, ... }:

{
  home.username = "kieeps";
  home.homeDirectory = "/home/kieeps";
  home.stateVersion = "24.05";

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.btop.enable = true;

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
