rec {
  blackstar = {
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUBABNxOK/OLy08u01467rj/NMdc2SnKnYkUK/EUJlN root@blackstar";
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ1XlQkBcUiwKdpDqgpx8UG5qT+r7aepRfQbB/M6PYuL luna@blackstar";
  };

  crona = {
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGqjgwVNyOXW0dl9GNgu5/y9KuDF+NCKnmcSUYQPFbO luna@crona";
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFKzBl57zM1v3tF5fhK6m7hJXJF9KK7qGuyWFDP+Jys root@crona";
  };

  tsubaki = {
    luna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcZaUMmxj09P5CSrRbLcZuO5L601EY5ag6oYHmqAnwf luna@tsubaki";
    root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVy6EUygJcY5EDs1W8dQFkxiBTZh2yOyR4g1PhH0DeQ root@tsubaki";
  };

  all = [
    blackstar.luna
    blackstar.root
    crona.luna
    crona.root
  ];
}
