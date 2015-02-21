#!/bin/bash

# Test whether a Homebrew formula is already installed
# $1 - formula name (may include options)
formula_exists() {
    if $(brew list $1 >/dev/null); then
        printf "%s already installed.\n" "$1"
        return 0
    fi

    e_warning "Missing formula: $1"
    return 1
}