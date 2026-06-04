{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      develop-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./develop-pc/configuration.nix
        ];
      };

      mgmt-pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}