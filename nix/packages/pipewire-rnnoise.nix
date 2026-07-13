{
  lib,
  writeTextDir,

  rnnoise-plugin,

  priority ? 99,
  vadThreshold ? 95,
  vadGracePeriod ? 200,
  retroactiveVadGracePeriod ? 0,
}:
let
  path = "share/pipewire/pipewire.conf.d/${toString priority}-rnnoise.conf";

  meta = {
    description = "Noise cancelling plugin for pipewire";
    maintainers = [ lib.maintainers.luna-the-tuna ];
    platforms = lib.platforms.linux;
  };

  passthru = {
    requiredLadspaPackages = [ rnnoise-plugin ];
  };

  config."context.modules" = lib.singleton {
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
          "VAD Threshold (%)" = vadThreshold;
          "VAD Grace Period (ms)" = vadGracePeriod;
          "Retroactive VAD Grace (ms)" = retroactiveVadGracePeriod;
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
in
writeTextDir path (builtins.toJSON config) // { inherit meta passthru; }
