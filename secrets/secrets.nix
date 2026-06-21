let
  keys = import ./keys.nix;
in
{
  "blackstar/users/luna.age".publicKeys = [
    keys.blackstar.luna
    keys.blackstar.root
  ];

  "blackstar/users/root.age".publicKeys = [
    keys.blackstar.luna
    keys.blackstar.root
  ];

  "crona/users/luna.age".publicKeys = [
    keys.crona.luna
    keys.crona.root
  ];

  "crona/users/root.age".publicKeys = [
    keys.crona.luna
    keys.crona.root
  ];
}
