{ withSystem, ... }:
{
  flake.overlays.default =
    final: prev:
    (withSystem prev.stdenv.hostPlatform.system (
      { inputs', ... }:
      {
        zen-browser = inputs'.zen-browser.packages.default;
      }
    ));
}
