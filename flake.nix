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
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
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

      mkHomeManagerConfig =
        host: system: modules_list:
	home-manager.lib.homeManagerConfiguration {
	  pkgs = import nixpkgs { inherit system; };
          modules = modules_list;
          extraSpecialArgs = {
            inherit inputs;
            globals = import ./hosts/globals.nix;
            locals = import ./hosts/${host}/locals.nix;
          };
        };
    in
    {
      nixosConfigurations = {
        yoyo = mkNixosConfig "yoyo" [
          ./hosts/yoyo
        ];

        numerino = mkNixosConfig "numerino" [
          ./hosts/numerino
        ];
      };

      homeConfigurations = {
      	boxypi = mkHomeManagerConfig "boxypi" "aarch64-linux" [
	  ./hosts/boxypi
	];
      };
    };
}
