{
  inputs,
  config,
  mkSystemModule,
  lib,
  ...
}:
let
  inherit (config.soul.desktop) enable;

  flavor = "mocha";
  accent = "mauve";

  palette = lib.importJSON "${inputs.catppuccin-palette}/palette.json";
  colors = (lib.getAttr flavor palette).colors;
in
mkSystemModule {
  shared._module.args = {
    inherit colors;
  };

  shared.soul.home._module.args = {
    inherit colors;
  };

  shared.catppuccin = {
    inherit enable flavor accent;

    autoEnable = enable;
    sources.palette = inputs.catppuccin-palette;
  };

  shared.soul.home.catppuccin = {
    inherit enable flavor accent;

    autoEnable = true;
    mpv.enable = false;
    sources.palette = inputs.catppuccin-palette;
  };

  nixos.catppuccin = {
    plymouth.enable = false;
  };
}
