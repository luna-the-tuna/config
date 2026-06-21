{
  description = "My system configurations in a Nix flake";
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./flake;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
}
