rec {
  blackstar = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUBABNxOK/OLy08u01467rj/NMdc2SnKnYkUK/EUJlN root@blackstar";
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ1XlQkBcUiwKdpDqgpx8UG5qT+r7aepRfQbB/M6PYuL luna@blackstar";
  };

  crona = {
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGqjgwVNyOXW0dl9GNgu5/y9KuDF+NCKnmcSUYQPFbO luna@crona";
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFKzBl57zM1v3tF5fhK6m7hJXJF9KK7qGuyWFDP+Jys root@crona";
  };

  all = [
    blackstar.luna
    blackstar.root
    crona.luna
    crona.root
  ];
}
