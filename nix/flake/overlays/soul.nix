{ withSystem, ... }:
{
  flake.overlays.default = final: prev: {
    soul = withSystem prev.stdenv.hostPlatform.system ({ self', ... }: self'.packages);
  };
}
