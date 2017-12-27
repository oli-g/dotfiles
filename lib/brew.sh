#!/bin/bash

# Test whether a Homebrew formula is already installed
# $1 - formula name
formula_exists() {
    if $(brew list "$1" >/dev/null); then
        printf "%s formula already installed.\n" "$1"
        return 0
    fi
    e_warning "Missing formula: $1"
    return 1
}

# Test whether a Homebrew tap is already installed
# $1 - tap name
tap_exists() {
	if $(brew tap | grep "$1" >/dev/null); then
        printf "%s tap already installed.\n" "$1"
        return 0
    fi
    e_warning "Missing tap: $1"
    return 1
}
