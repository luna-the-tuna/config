[doc("Kill the current Quickshell instance and replace it with the one from this repo")]
[linux]
start:
    quickshell kill
    quickshell -p ../../config/quickshell
