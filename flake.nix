{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
    { nixpkgs-stable, nixpkgs-unstable, ... }@inputs:
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
        yoyo = mkNixosConfig nixpkgs-unstable.lib.nixosSystem inputs.home-manager-unstable "yoyo" [
          ./hosts/yoyo
        ];

        numerino = mkNixosConfig nixpkgs-unstable.lib.nixosSystem inputs.home-manager-unstable "numerino" [
          ./hosts/numerino
        ];

        toobig = mkNixosConfig nixpkgs-unstable.lib.nixosSystem inputs.home-manager-unstable "toobig" [
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
