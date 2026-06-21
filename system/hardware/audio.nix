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
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      extraConfig.pipewire."10-quantum" = {
        "context.properties"."default.clock.min-quantum" = 1024;
      };

      extraConfig.pipewire."99-rnnoise" = {
        "context.modules" = lib.singleton {
          name = "libpipewire-module-filter-chain";

          args = {
            "node.description" = "Noise cancelling source";
            "media.name" = "Noise cancelling source";

            "filter.graph".nodes = lib.singleton {
              type = "ladspa";
              name = "rnnoise";
              label = "noise_suppressor_mono";
              plugin = "librnnoise_ladspa";

              control = {
                "VAD Threshold (%)" = 95;
                "VAD Grace Period (ms)" = 200;
                "Retroactive VAD Grace (ms)" = 0;
              };
            };

            "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "audio.rate" = 48000;
            };

            "playback.props" = {
              "node.name" = "rnnoise_source";
              "media.class" = "Audio/Source";
              "audio.rate" = 48000;
            };
          };
        };
      };

      extraLadspaPackages = [
        pkgs.rnnoise-plugin.ladspa
      ];
    };

    environment.systemPackages = [
      pkgs.wiremix
      pkgs.qpwgraph
    ];
  };
}
