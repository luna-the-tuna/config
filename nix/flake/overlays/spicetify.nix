{ withSystem, ... }:
{
  flake.overlays.spicetify = final: prev: {
    spicePackages = withSystem prev.stdenv.hostPlatform.system (
      { inputs', ... }: inputs'.spicetify.legacyPackages
    );
  };
}
