{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };
  outputs = {
    self,
    nixpkgs,
    disko,
    home-manager,
    lanzaboote,
    ...
  } @ attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      nixos = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs // {pkgs = pkgs;};
          modules = [
            ./configuration.nix
            disko.nixosModules.disko
            ./disk-config.nix
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            ./secureboot.nix
          ];
        };
    };
  };
}
