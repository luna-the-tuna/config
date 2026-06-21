{ self, ... }:
let
  script = ''
    cd "${self}"
    locker
    touch "$out"
  '';
in
{
  perSystem =
    { pkgs, ... }:
    {
      checks.locker = pkgs.runCommand "locker-check" {
        meta.description = "Check for duplicate lockfile entries";
        nativeBuildInputs = [ pkgs.locker ];
      } script;
    };
}
