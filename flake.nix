{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { nixpkgs, ... }:
    let
      mkHost = hostName: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./${hostName}/configuration.nix ];
      };
    in {
      nixosConfigurations = {
        develop-pc = mkHost "develop-pc";
        mgmt-pc = mkHost "mgmt-pc";
      };
    };
}