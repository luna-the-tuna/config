{
  lib,
  writeTextDir,

  priority ? 10,
  quantumValue ? 1024,
}:
let
  path = "share/pipewire/pipewire.conf.d/${toString priority}-quantum.conf";

  meta = {
    description = "Quantum plugin for pipewire";
    maintainers = [ lib.maintainers.luna-the-tuna ];
    platforms = lib.platforms.linux;
  };

  config = {
    "context.properties"."default.clock.min-quantum" = quantumValue;
  };
in
writeTextDir path (builtins.toJSON config) // { inherit meta; }
