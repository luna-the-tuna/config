{ lib, ... }:
{
  flake.lib.hypr.mkKeyBind = keys: command: {
    _args = [
      keys
      (lib.generators.mkLuaInline command)
    ];
  };

  flake.lib.hypr.mkMouseBind = buttons: command: {
    _args = [
      buttons
      (lib.generators.mkLuaInline command)
      { mouse = true; }
    ];
  };

  flake.lib.hypr.mkEnv = key: value: {
    _args = [
      key
      value
    ];
  };

  flake.lib.hypr.mkCurve = name: points: {
    _args = [
      name
      {
        inherit points;
        type = "bezier";
      }
    ];
  };

  flake.lib.hypr.mkHandler = event: handler: {
    _args = [
      event
      (lib.generators.mkLuaInline handler)
    ];
  };
}
