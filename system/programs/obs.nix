{
  config,
  lib,
  mkNixosModule,
  pkgs,
  ...
}:
let
  cfg = config.soul.programs.obs;
in
mkNixosModule {
  options.soul.programs.obs = {
    enable = lib.mkEnableOption "obs";
  };

  config.programs.obs-studio = {
    inherit (cfg) enable;

    plugins = [
      pkgs.obs-studio-plugins.obs-vaapi
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}
