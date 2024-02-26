{ nixpkgs, home-manager, ... }: {
  nixosConfigurations = {
    tinker = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        defaults.nix
        users.nix
        ./tinker
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.wury = import users/wury/wury.nix;
        }
      ];
    };
    waterfall = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        defaults.nix
        users.nix
        wsl.nix
        ./waterfall
      ];
    };
  };
}
