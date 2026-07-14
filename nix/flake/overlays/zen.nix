{ withSystem, ... }:
{
  flake.overlays.zen = final: prev: {
    zen-browser = withSystem prev.stdenv.hostPlatform.system (
      { inputs', ... }: inputs'.zen-browser.packages.default
    );
  };
}
