{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "config-shell";
        meta.description = "The development environment for this flake";
        packages = [ pkgs.lix ];
      };
    };
}
