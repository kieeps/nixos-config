{ config, hostname, ... }:

{
  xdg.configFile."nh/hosts.toml".text = ''
    [default]
    config = "nixosConfigurations"
    hostname = "${hostname}"

    [hosts.${hostname}]
    flake = "${config.home.homeDirectory}/nixos-config"
  '';

  home.packages = [
    # Laptop-specific packages
    tlp
    nextcloud-client
    moonlight-qt
  ];
}
