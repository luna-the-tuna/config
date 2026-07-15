{ lib, ... }:
{
  flake.lib.types.account = lib.types.submodule (
    { name, config, ... }: {
      options = {
        name = lib.mkOption {
          defaultText = "<name>";
          description = "The username of the user.";
          example = "maka";
          type = lib.types.strMatching "([a-z0-9]+)";
        };

        primary = lib.mkOption {
          default = false;
          description = "Whether this user is the primary user of the system.";
          example = true;
          type = lib.types.bool;
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
          defaultText = lib.literalExpression "\${firstName} \${lastName}";
          description = "The full name of the user.";
          example = "Maka Albarn";
          type = lib.types.str;
        };
      };

      config = {
        name = lib.mkDefault name;
        fullName = "${config.firstName} ${config.lastName}";
      };
    }
  );
}
