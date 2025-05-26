{ config, pkgs, hostname, ... }:

{
  xdg.configFile."nh/hosts.toml".text = ''
    [default]
    config = "nixosConfigurations"
    user = "kieeps"
    hostname = "${hostname}"

    [hosts.${hostname}]
    flake = "${config.home.homeDirectory}/nixos-config"
  '';

  home.packages = with pkgs; [
    # Laptop-specific packages
    tlp
    nextcloud-client
    moonlight-qt
  ];
}
