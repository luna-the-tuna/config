{ lib, ... }:
{
  flake.lib.types.user = lib.types.submodule (
    {
      config,
      name ? null,
      ...
    }:
    {
      options = {
        primary = lib.mkOption {
          default = false;
          defaultText = "<name>";
          description = "Whether this is the primary user on the system.";
          readOnly = true;
          type = lib.types.bool;
        };

        name = lib.mkOption {
          description = "The username of the user.";
          example = "maka";
          type = lib.types.strMatching "([a-z0-9]+)";
        };

        firstName = lib.mkOption {
          description = "The first name of the user.";
          example = "Maka";
          type = lib.types.str;
        };

        lastName = lib.mkOption {
          description = "The last name of the user.";
          example = "Albarn";
          type = lib.types.str;
        };

        fullName = lib.mkOption {
          defaultText = "\${firstName} \${lastName}";
          description = "The full name of the user.";
          example = "Maka Albarn";
          type = lib.types.str;
        };

        email = lib.mkOption {
          description = "The email address of the user.";
          example = "maka.albarn@shibusen.org";
          type = lib.types.str;
        };
      };

      config = {
        name = lib.mkDefault name;
        fullName = lib.mkDefault "${config.firstName} ${config.lastName}";
      };
    }
  );
}
