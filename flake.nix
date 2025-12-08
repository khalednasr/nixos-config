{
  description = "NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      mkNixosConfig = host: modules_list:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            globals = import ./hosts/globals.nix;
            locals = import  ./hosts/${host}/locals.nix;
          };
          modules = modules_list;
        };
    in {
      nixosConfigurations = {
        yoyo = mkNixosConfig "yoyo" [ ./hosts/yoyo ./modules/core ./modules/desktop];
      };
    };
}
