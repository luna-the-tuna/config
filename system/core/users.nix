{
  config,
  keys,
  lib,
  mkSystemModule,
  pkgs,
  self,
  ...
}:
let
  cfg = config.soul.users;

  users = builtins.attrValues cfg;
  primaryUserError = throw "must have exactly one primary user defined";
  existingGroups = lib.mapAttrsToList (name: group: group.name) config.users.groups;

  doesGroupExist = name: builtins.elem name existingGroups;
  getUserPasswordFile = user: "${self}/secrets/${config.networking.hostName}/users/${user.name}.age";

  groups = builtins.filter doesGroupExist [
    "audio"
    "gamemode"
    "video"
    "wheel"
  ];
in
mkSystemModule {
  shared.options.soul.users = lib.mkOption {
    default = { };
    description = "The users to create on the system.";
    type = lib.types.attrsOf self.lib.types.user;
  };

  shared.config.lib.soul.users = {
    primary = lib.findSingle (user: user.primary) primaryUserError primaryUserError users;
  };

  darwin.config = {
    system.primaryUser = config.lib.soul.users.primary.name;
    users.knownUsers = map (user: user.name) users;
  };

  nixos.config = {
    users.mutableUsers = false;
  };

  shared.config.users.users = lib.mapAttrs (name: user: {
    description = user.fullName;
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = keys.all;
  }) cfg;

  nixos.config.users.users = lib.mapAttrs (name: user: {
    isNormalUser = true;
    extraGroups = groups;
    hashedPasswordFile = config.age.secrets."users/${user.name}".path;
  }) cfg;

  nixos.config.age.secrets = lib.mapAttrs' (
    name: user: lib.nameValuePair "users/${user.name}" { file = getUserPasswordFile user; }
  ) cfg;

  darwin.config.users.users = self.lib.attrsets.imapAttrs1 (index: name: user: {
    uid = 500 + index;
    createHome = true;
    home = "/Users/${user.name}";
  }) cfg;

  shared.config.home-manager.users = lib.mapAttrs (name: user: {
    _module.args = { inherit user; };
  }) cfg;
}
