{ self, lib, ... }:
let
  script = ''
    cd "${self}"
    locker
    touch "$out"
  '';

  meta = {
    description = "Check for duplicate lockfile entries";
    maintainers = [ lib.maintainers.luna-the-tuna ];
    platforms = lib.platforms.all;
  };
in
{
  perSystem = { pkgs, ... }: {
    checks.locker = pkgs.runCommand "locker-check" {
      inherit meta;
      nativeBuildInputs = [ pkgs.locker ];
    } script;
  };
}
