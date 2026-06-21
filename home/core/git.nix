{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };

    settings = {
      core.ignorecase = true;
      pull.rebase = true;
      init.defaultBranch = "main";

      user = {
        name = user.fullName;
        email = user.email;
      };

      alias = {
        lga = "log --decorate --oneline --graph";
        put = "push --set-upstream";
        ui = "!${lib.getExe pkgs.lazygit}";
      };
    };
  };
}
