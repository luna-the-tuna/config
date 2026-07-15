{ lib, config, ... }:
let
  cfg = config.soul.packages;
in
{
  options.soul.packages = lib.mkOption {
    default = [ ];
    description = "Extra packages to install on the system.";
    example = lib.literalExpression "[ pkgs.crosspatch pkgs.syncplay ]";
    type = lib.types.listOf lib.types.package;
  };

  config.environment = {
    defaultPackages = [ ];
    systemPackages = cfg;
  };
}
