{
  description = "movement oriented cs: source server";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    steam-fetcher.inputs.nixpkgs.follows = "nixpkgs";
    steam-fetcher.url = "github:nix-community/steam-fetcher";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./packages ];

      flake = {
        #        nixosModules.default = import ./Xd/service.nix inputs;
      };
    };
}
