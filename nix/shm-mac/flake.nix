{
  description = "macOS packages shm-darwin";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, ... }: let
    supportedSystems = [ "x86_64-darwin" "aarch64-darwin" ];
    forEachSystem = f: builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) supportedSystems);
  in {
    packages = forEachSystem (system: {
      shm-darwin = import ./packages.nix {
        pkgs = import nixpkgs { inherit system; };
        inherit system;
      };
    });
  };
}
