{ config, ... }:
{
  home.stateVersion = "26.11";

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
        name = "Luna Heyman";
        email = "luna@toodeluna.net";
      };
    };
  };
}
