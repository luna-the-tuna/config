{
  self,
  config,
  mkNixosModule,
  ...
}:
let
  inherit (config.soul) desktop;
in
mkNixosModule {
  soul.home.programs.quickshell = {
    enable = desktop.hyprland.enable;
    activeConfig = "default";
    configs.default = "${self}/config/quickshell";
  };
}
