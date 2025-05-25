{
  outputs = { nixpkgs, home-manager, flake-utils, ... }: {
    nixosConfigurations = {
      Lappen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
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
    };

    # 👇 Add this block below your nixosConfigurations
    osConfigurations = {
      Lappen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
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
    };
  };
}
