{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "config-shell";
      meta.description = "The development environment for this flake";

      packages = builtins.concatLists [
        (lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.quickshell)

        [
          pkgs.agenix
          pkgs.just
          pkgs.lix
          pkgs.nh
        ]
      ];
    };
  };
}
