export NH_ELEVATION_STRATEGY := "run0"
export NH_DARWIN_FLAKE := justfile_directory()
export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()

nh_command := if os() == "macos" { "darwin" } else { "os" }
nh_output := "./result"

[doc("Build the specified host configuration asdf")]
[group("systems")]
build hostname=`hostname`:
    nh {{ nh_command }} build -H {{ hostname }} -o {{ nh_output }}

[doc("Switch to the specified host configuration")]
[group("systems")]
switch hostname=`hostname`:
    nh {{ nh_command }} switch -H {{ hostname }} -o {{ nh_output }}

[arg("scope", pattern="all|profile|user")]
[doc("Run garbage collection on the current system")]
[group("systems")]
clean scope="all":
    nh clean all

[doc("Edit the specified secret file")]
[group("secrets")]
[working-directory("./secrets")]
edit-secret path:
    agenix -e {{ path }}

[doc("Decrypt and display the specified secret file")]
[group("secrets")]
[working-directory("./secrets")]
show-secret path:
    agenix -d {{ path }}

[doc("Replace the current Quickshell instance with the one in this repo")]
[group("development")]
quickshell:
    quickshell kill || true
    quickshell -p ./quickshell
