{
  description = "Flake-based NixOS config with host-aware Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }@inputs: let
    system = "x86_64-linux";

  mkPkgs = system: import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "olm-3.2.16"
        "yubikey-manager-qt-1.2.5"
      ];
    };
  };


    # Optional: override unstable for both systems
    overrideUnstable = pkgs: {
      unstable = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };

    nixosConfigurations = {
      Lappen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.config.packageOverrides = overrideUnstable;
          }
          ./hosts/Lappen/hardware-configuration.nix
          ./hosts/Lappen/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kieeps = import ./users/kieeps.nix;
          }
        ];
      };

      Supern = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.config.packageOverrides = overrideUnstable;
          }
          ./hosts/Supern/hardware-configuration.nix
          ./hosts/Supern/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kieeps = import ./users/kieeps.nix;
          }
        ];
      };
    };

  in {
    inherit nixosConfigurations;

    osConfigurations = {
      Lappen = nixosConfigurations.Lappen;
      Supern = nixosConfigurations.Supern;
    };

    homeConfigurations = {
      "kieeps@Lappen" = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;
        modules = [
          ./users/kieeps.nix
          ./users/kieeps-Lappen.nix
        ];
        extraSpecialArgs = {
          hostname = "Lappen";
        };
      };

      "kieeps@Supern" = home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;
        modules = [
          ./users/kieeps.nix
          ./users/kieeps-Supern.nix
        ];
        extraSpecialArgs = {
          hostname = "Supern";
        };
      };
    };
  };
}
