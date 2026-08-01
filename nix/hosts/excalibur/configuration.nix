{
  inputs,
  config,
  pkgs,
  ...
}:
{
  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
  };

  soul.home = {
    imports = [ ./home.nix ];
  };

  programs = {
    oomf-time.enable = true;
  };

  soul.packages = [
    pkgs.vscode
  ];

  environment.shells = [
    pkgs.nushell
  ];

  fonts.packages = [
    pkgs.maple-mono.NF
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    mutableTaps = false;
    user = config.system.primaryUser;

    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };

    casks = [
      "citrix-workspace"
      "microsoft-outlook"
      "microsoft-teams"
      "sol"
    ];
  };
}
