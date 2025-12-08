{
  description = "NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      mkNixosConfig =
        host: modules_list:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            globals = import ./hosts/globals.nix;
            locals = import ./hosts/${host}/locals.nix;
          };
          modules = modules_list;
        };
    in
    {
      nixosConfigurations = {
        yoyo = mkNixosConfig "yoyo" [
          ./hosts/yoyo
          ./modules/core
          ./modules/desktop
        ];
      };
    };
}
