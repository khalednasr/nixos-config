{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
    connect-timeout = 5;
  };

  outputs =
    { nixpkgs, home-manager, nixos-raspberrypi, ... }@inputs:
    let
      mkNixosConfig =
        nixosSystem: host: modules:
        nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit nixos-raspberrypi;
            globals = import ./hosts/globals.nix;
            locals = import ./hosts/${host}/locals.nix;
          };
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        yoyo = mkNixosConfig nixpkgs.lib.nixosSystem "yoyo" [
          ./hosts/yoyo
        ];

        numerino = mkNixosConfig nixpkgs.lib.nixosSystem "numerino" [
          ./hosts/numerino
        ];

        boxypi = mkNixosConfig nixos-raspberrypi.lib.nixosSystem "boxypi" [
          ./hosts/boxypi
        ];
      };
    };
}
