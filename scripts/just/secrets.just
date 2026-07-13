[doc("Edit the specified secret file")]
[working-directory("../../nix/secrets")]
edit path:
    agenix -e {{ path }}

[doc("Decrypt and show the specified secret file")]
[working-directory("../../nix/secrets")]
show path:
    agenix -d {{ path }}
