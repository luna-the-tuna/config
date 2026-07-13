{ lib, ... }:
let
  script = ''
    cog install-hook --all --overwrite
  '';
in
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";
      shellHook = script;

      packages = [
        pkgs.cocogitto
        pkgs.lix
      ];

      meta = {
        description = "The development environment for this configuration";
        maintainers = [ lib.maintainers.luna-the-tuna ];
        platforms = lib.platforms.all;
      };
    };
  };
}
