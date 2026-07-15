{
  config,
  lib,
  mkNixosModule,
  pkgs,
  ...
}:
let
  cfg = config.soul.hardware.audio;
in
mkNixosModule {
  options.soul.hardware.audio = {
    enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    security = {
      rtkit.enable = true;
    };

    services.pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      configPackages = [
        pkgs.soul.pipewire-quantum
        pkgs.soul.pipewire-rnnoise
      ];
    };

    environment.systemPackages = [
      pkgs.qpwgraph
      pkgs.wiremix
    ];
  };
}
