{
  config,
  lib,
  mkNixosModule,
  pkgs,
  ...
}:
let
  cfg = config.soul.programs.resolve;
  isAmd = config.soul.hardware.amdgpu.enable;
in
mkNixosModule {
  options.soul.programs.resolve = {
    enable = lib.mkEnableOption "davinci-resolve";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.extraPackages = lib.optional isAmd pkgs.rocmPackages.clr.icd;
    environment.systemPackages = [ pkgs.davinci-resolve ];
  };
}
