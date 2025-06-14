#!/usr/bin/env zsh

this_file=$(basename $0)

print "\n$this_file - macOS auto configuration script\n"


# ------------------------------------------------------------------------------
# Function declarations / implementations
# ------------------------------------------------------------------------------

function logger() {
    local variant="${1:-info}"
    local message="${2:-}"

    if [ -z "$message" ]; then
        return
    fi

    case "$variant" in
        info)
            printf "\033[34m%-8s\033[0m %s\n" "info" "$message"
            ;;
        success)
            printf "\033[32m%-8s\033[0m %s\n" "success" "$message"
            ;;
        warning)
            printf "\033[33m%-8s\033[0m %s\n" "warning" "$message"
            ;;
        error)
            printf "\033[31m%-8s\033[0m %s\n" "error" "$message"
            ;;
    esac
}

function apply_settings() {
    return 0
}

function read_settings() {
    return 0
}

function restore_settings() {
    return 0
}

function show_usage() {
    print "Usage 1: $this_file read"
    print "Usage 2: $this_file apply"
    print "Usage 3: $this_file rollback"
    print ""
}


# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

case $1 in
    "apply")
        apply_settings
        ;;
    "read")
        read_settings
        ;;
    "restore")
        restore_settings
        ;;
    *)
        show_usage
        exit 1
        ;;
esac

exit 0
