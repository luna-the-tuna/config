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

      packages = lib.flatten [
        pkgs.agenix
        pkgs.cocogitto
        pkgs.just
        pkgs.lix
        pkgs.nh
        (lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.quickshell)
      ];

      meta = {
        description = "The development environment for this configuration";
        maintainers = [ lib.maintainers.luna-the-tuna ];
        platforms = lib.platforms.all;
      };
    };
  };
}
