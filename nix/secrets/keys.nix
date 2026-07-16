rec {
  blackstar = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUBABNxOK/OLy08u01467rj/NMdc2SnKnYkUK/EUJlN root@blackstar";
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ1XlQkBcUiwKdpDqgpx8UG5qT+r7aepRfQbB/M6PYuL luna@blackstar";
  };

  crona = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLVGNKpntJdD6obLOszSVV8lVC9g/H5qZUuMX7jV4wx root@crona";
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGqjgwVNyOXW0dl9GNgu5/y9KuDF+NCKnmcSUYQPFbO luna@crona";
  };

  all = [
    crona.root
    crona.luna
  ];
}
