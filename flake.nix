{
  description = "My Linux and MacOS system configurations in a Nix flake";
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./nix/flake;

  inputs = {
    # keep-sorted start block=yes newline_separated=yes
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    easy-hosts = {
      url = "github:tgirlcloud/easy-hosts";
    };

    extersia-pkgs = {
      url = "github:extersia-org/pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "git+https://git.lix.systems/lix-project/lix";
      flake = false;
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.flake-utils.follows = "flake-utils";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    systems = {
      url = "github:nix-systems/default";
    };

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };
}
