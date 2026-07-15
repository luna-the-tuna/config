{
  config,
  lib,
  mkSystemModule,
  self,
  ...
}:
let
  cfg = config.soul.users.admin;
  users = builtins.attrValues config.soul.users.accounts;

  onlyUser = if builtins.length users == 1 then builtins.head users else null;
  primaryUser = lib.findSingle (user: user.primary) onlyUser null users;
in
mkSystemModule {
  shared.options.soul.users.admin = lib.mkOption {
    description = "The primary user of the system.";
    readOnly = true;
    type = lib.types.nullOr self.lib.types.account;
  };

  shared.config = {
    soul.users = {
      admin = primaryUser;
    };

    assertions = lib.singleton {
      assertion = cfg != null;
      message = "at least one primary user must be defined on the system";
    };
  };

  darwin.config = {
    system.primaryUser = cfg.name;
  };
}
