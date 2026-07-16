{
  config,
  lib,
  mkSystemModule,
  pkgs,
  ...
}:
let
  inherit (config.soul.users) admin;

  settings = {
    core.ignorecase = false;
    pull.rebase = true;
    init.defaultBranch = "main";
  };

  settings.alias = {
    lga = "log --decorate --oneline --graph";
    put = "push --set-upstream";
    ui = "!${lib.getExe pkgs.lazygit}";
    check = "!${lib.getExe pkgs.cocogitto} check";
  };
in
mkSystemModule {
  nixos.programs.git = {
    enable = true;

    config = settings // {
      user.name = admin.fullName;
      user.email = admin.email;
    };
  };

  shared.soul.home = { config, user, ... }: {
    programs.git = {
      enable = true;

      signing = {
        signByDefault = true;
        format = "ssh";
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };

      settings = settings // {
        user.name = user.fullName;
        user.email = user.email;
      };
    };
  };
}
