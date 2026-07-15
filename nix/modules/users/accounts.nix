{
  config,
  keys,
  lib,
  mkSystemModule,
  self,
  ...
}:
let
  cfg = config.soul.users.accounts;
  users = builtins.attrValues cfg;

  existingGroups = lib.mapAttrsToList (name: group: group.name) config.users.groups;
  doesGroupExist = groupName: builtins.elem groupName existingGroups;

  mkUserPair = user: lib.nameValuePair user.name;
  mapUsers = f: lib.listToAttrs (map (user: mkUserPair user (f user)) users);
  imapUsers = f: lib.listToAttrs (lib.imap0 (index: user: mkUserPair user (f index user)) users);

  requiredGroups = builtins.filter doesGroupExist [
    "audio"
    "gamemode"
    "video"
    "wheel"
  ];
in
mkSystemModule {
  shared.options.soul.users.accounts = lib.mkOption {
    default = { };
    description = "The accounts to create on the system.";
    type = lib.types.attrsOf self.lib.types.account;
  };

  shared.config = {
    users.users = mapUsers (user: {
      description = user.fullName;
    });

    home-manager.users = mapUsers (user: {
      _module.args = { inherit user; };
    });

    assertions = lib.singleton {
      assertion = builtins.length users > 0;
      message = "at least one user account must be created";
    };
  };

  nixos.config = {
    users.users = mapUsers (user: {
      isNormalUser = true;
      extraGroups = requiredGroups;
      hashedPasswordFile = config.age.secrets."passwords/${user.name}".path;
      openssh.authorizedKeys.keys = keys.all;
    });

    age.secrets = lib.mapAttrs' (name: user: {
      name = "passwords/${user.name}";
      value.file = config.lib.users.getPasswordFile user.name;
    }) cfg;
  };

  darwin.config = {
    users = {
      knownUsers = map (user: user.name) users;
    };

    users.users = imapUsers (
      index: user: {
        uid = 500 + index + 1;
        createHome = true;
        home = "/Users/${user.name}";
      }
    );
  };
}
