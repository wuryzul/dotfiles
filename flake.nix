{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      template = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          systems/defaults.nix
          systems/users.nix
          systems/template
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wury = import users/wury/wury.nix;
          }
        ];
      };
      tinker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          systems/defaults.nix
          systems/users.nix
          systems/tinker
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
          systems/defaults.nix
          systems/users.nix
          systems/wsl.nix
          systems/waterfall
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wury = import users/wury/wury.nix;
          }
        ];
      };
      work = nixpks.lib.nixoSystem {
        system = "x86_64-linux";
        modules = [
          systems/defaults.nix
          systems/users.nix
          systems/wsl.nix
          systems/work
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wury = import users/wury/wury.nix;
          }
        ];
      }
    };
  };
}
