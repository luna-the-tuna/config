let
  keys = import ./keys.nix;
in
{
  "blackstar/passwords/luna.age".publicKeys = [
    keys.blackstar.root
    keys.blackstar.luna
  ];

  "blackstar/passwords/root.age".publicKeys = [
    keys.blackstar.root
    keys.blackstar.luna
  ];

  "crona/passwords/luna.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];

  "crona/passwords/root.age".publicKeys = [
    keys.crona.root
    keys.crona.luna
  ];
}
