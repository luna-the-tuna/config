# Recipes for working with agenix secret files
mod secrets "./scripts/just/secrets.just"

# Recipes for working with the Quickshell configuration
mod quickshell "./scripts/just/quickshell.just"

export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()
export NH_DARWIN_FLAKE := justfile_directory()

hostname := `hostname`

nh_output := "./result"
nh_builder := if os() == "macos" { "darwin" } else { "os" }

[doc("Build the specified host configuration")]
[group("systems")]
build hostname=hostname:
    nh {{ nh_builder }} build -H {{ hostname }} -o {{ nh_output }} --show-trace

[doc("Switch to the specified host configuration")]
[group("systems")]
switch hostname=hostname:
    nh {{ nh_builder }} switch -H {{ hostname }} -o {{ nh_output }} --show-trace

[doc("Run garbage collection on the system")]
[group("utilities")]
clean: && switch
    nh clean all
