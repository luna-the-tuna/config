{ inputs, ... }:
{
  imports = [ inputs.treefmt.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      just.enable = true;
      nixfmt.enable = true;
      prettier.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;
    };
  };
}
