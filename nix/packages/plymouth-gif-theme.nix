{
  self,
  lib,
  stdenv,
  writeText,

  envsubst,
  ffmpeg,

  gif ? "${self}/assets/gifs/crona-and-maka.gif",
  fps ? 16,
}:
assert gif != null && (builtins.isPath gif || builtins.isString gif);
assert lib.hasSuffix ".gif" gif;
assert fps > 0;
let
  name = "plymouth-gif-theme";
  description = "A plymouth theme that displays a custom GIF";

  themeFile = writeText "${name}.plymouth" ''
    [Plymouth Theme]
    Name=$pname
    Description=$description
    ModuleName=script

    [script]
    ImageDir=$out/share/plymouth/themes/$pname/frames
    ScriptFile=$out/share/plymouth/themes/$pname/$pname.script
  '';

  scriptFile = writeText "${name}.script" ''
    frame_count = $frame_count;
    current_frame = 0;

    for (frame_index = 0; frame_index < frame_count; frame_index++) {
      frame_number = frame_index + 1;
      frame_path = "frame-" + frame_number + ".png";
      frames[frame_index] = Image(frame_path);
    }

    screen_width = Window.GetWidth();
    screen_height = Window.GetHeight();

    image_width = frames[0].GetWidth();
    image_height = frames[0].GetHeight();

    center_x = (screen_width / 2) - (image_width / 2);
    center_y = (screen_height / 2) - (image_height / 2);

    sprite = Sprite();
    sprite.SetImage(frames[0]);
    sprite.SetPosition(center_x, center_y, 0);

    fun refresh_callback() {
      sprite.SetImage(frames[current_frame]);
      current_frame = (current_frame + 1) % frame_count;
    }

    Plymouth.SetRefreshFunction(refresh_callback);
    Plymouth.SetRefreshRate(${toString fps});

    Window.SetBackgroundTopColor(1, 1, 1);
    Window.SetBackgroundBottomColor(1, 1, 1);
  '';
in
stdenv.mkDerivation (finalAttrs: {
  inherit description;
  pname = name;
  version = "0.0.1";

  nativeBuildInputs = [
    envsubst
    ffmpeg
  ];

  phases = [
    "setupPhase"
    "convertPhase"
    "themePhase"
    "installPhase"
  ];

  setupPhase = ''
    mkdir "./theme"
    cd "./theme"
  '';

  convertPhase = ''
    mkdir -p "./frames"
    ffmpeg -i "${gif}" "./frames/frame-%d.png"
  '';

  themePhase = ''
    export frame_count=$(find "./frames" -type f | wc -l)
    envsubst < "${themeFile}" > "./$pname.plymouth"
    envsubst < "${scriptFile}" > "./$pname.script"
  '';

  installPhase = ''
    mkdir -p "$out/share/plymouth/themes"
    cp -r "." "$out/share/plymouth/themes/plymouth-gif-theme"
  '';

  meta = {
    inherit (finalAttrs) description;
    maintainers = [ lib.maintainers.luna-the-tuna ];
    platforms = lib.platforms.all;
  };
})
