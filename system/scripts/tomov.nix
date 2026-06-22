{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.soul.scripts.tomov;
in
{
  options.soul.scripts.tomov = {
    enable = lib.mkEnableOption "tomov";
  };

  config.environment.systemPackages = lib.optional cfg.enable (
    pkgs.writeShellApplication {
      name = "tomov";

      runtimeInputs = [
        pkgs.ffmpeg
        pkgs.gum
      ];

      text = ''
        amount_of_audio_tracks=$(gum input --prompt "How many audio tracks should be converted? " --placeholder "3")

        if ! [[ $amount_of_audio_tracks =~ ^-?[0-9]+$ ]]; then
          gum log --level error "Amount of audio tracks must be a number."
          exit 1
        fi

        for file in "$@"; do
          file_name="''${file%.*}"
          output_path="''${file_name}-output"

          mkdir "$output_path"
          pushd "$output_path" || exit

          ffmpeg -i "../$file" -an -c:v copy "$file_name.mov"

          for ((track_index = 0; track_index < amount_of_audio_tracks; track_index++)); do
            ffmpeg -i "../$file" -map 0:a:$track_index -c:a pcm_s16le "''${file_name}-audio-''${track_index}.wav"
          done

          popd || exit
        done
      '';
    }
  );
}
