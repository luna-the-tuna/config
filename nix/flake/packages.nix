{
  inputs,
  lib,
  self,
  ...
}:
{
  perSystem =
    { system, pkgs, ... }:
    let
      packages = lib.packagesFromDirectoryRecursive {
        callPackage = lib.callPackageWith (pkgs // { inherit self inputs; });
        directory = "${self}/nix/packages";
      };
    in
    {
      packages = lib.filterAttrs (name: value: builtins.elem system value.meta.platforms) packages;
    };
}
