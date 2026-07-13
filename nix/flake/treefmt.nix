{
  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      keep-sorted.enable = true;
      nixfmt.enable = true;
      prettier.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;
    };
  };
}
