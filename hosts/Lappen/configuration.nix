{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  fonts = {
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

services.logind = {
  lidSwitch = "suspend";
  lidSwitchDocked = "ignore";
  powerKey = "suspend";
  extraConfig = ''
    HandleHibernateKey=ignore
    HandleLidSwitchHibernate=ignore
  '';
};

boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};
#  programs.zsh.enable = true;

# Steam
  programs.steam = {
    enable = true;
#    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

#  users.defaultUserShell = pkgs.zsh;

  # Bootloader.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.theme = true;
  networking.hostName = "Lappen"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.configurationLimit = 10;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  nix.settings.experimental-features = [ "nix-command flakes" ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.tailscale.enable = true;
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  ## virtualisation
  virtualisation = {
    containers = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.unstable.OVMF.override {
        secureBoot = true;
 #       tpmSupport = true;
      }).fd];
    };
  };
};
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.defaultSession = "plasma";
  services.xserver.displayManager = {
    lightdm = { 
      enable = true; 
      greeter.enable = false; 
    };
  };

  security.polkit.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
    videoDrivers = [ "amdgpu" ];
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.kieeps = {
    isNormalUser = true;
    description = "kieeps";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "podman" "render" "video" ];
    packages = with pkgs; [
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
      vscode
      openshift
      kubernetes
      kubernetes-helm
      jmeter
      android-tools
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
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
    "yubikey-manager-qt-1.2.5"
  ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "kieeps";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
];
environment.sessionVariables = {
  MOZ_USE_XINPUT2 = "1";
};
  system.stateVersion = "23.11"; # Did you read the comment?
}