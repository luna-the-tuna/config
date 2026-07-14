{ flake-parts-lib, lib, ... }:
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    lib = lib.mkOption {
      default = { };
      description = "Functions to export from this flake.";
      type = lib.types.attrsOf lib.types.unspecified;
    };
  };
}
