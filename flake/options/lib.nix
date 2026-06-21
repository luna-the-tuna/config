{ flake-parts-lib, lib, ... }:
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    lib = lib.mkOption {
      default = { };
      description = "Library functions to export from this flake.";
      type = lib.types.attrsOf lib.types.unspecified;
    };
  };
}
