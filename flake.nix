{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  outputs =
    { nixpkgs, nixpkgs-stable, ... }@inputs:
    let
      mkNixosConfig =
        nixosSystem: home-manager: host: modules:
        nixosSystem {
          specialArgs = {
            inputs = inputs // {
              inherit home-manager;
            };
            nixos-raspberrypi = inputs.nixos-raspberrypi;
            globals = import ./hosts/globals.nix;
            locals = import ./hosts/${host}/locals.nix;
          };
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        yoyo = mkNixosConfig nixpkgs.lib.nixosSystem inputs.home-manager "yoyo" [
          ./hosts/yoyo
        ];

        numerino = mkNixosConfig nixpkgs.lib.nixosSystem inputs.home-manager "numerino" [
          ./hosts/numerino
        ];

        toobig = mkNixosConfig nixpkgs.lib.nixosSystem inputs.home-manager "toobig" [
          ./hosts/toobig
        ];

        boxypi =
          mkNixosConfig inputs.nixos-raspberrypi.lib.nixosSystem inputs.home-manager-stable "boxypi"
            [
              ./hosts/boxypi
            ];
      };

      homeModules.devtools =
        { ... }:
        {
          imports = [ ./modules/core/devtools ];
        };
    };
}
