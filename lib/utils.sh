#!/bin/bash

# Header logging
e_header() {
    printf "$(tput setaf 7)%s$(tput sgr0)\n" "$@"
}

# Advice logging
e_advice() {
    printf "$(tput setaf 7)  %s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 136)! %s$(tput sgr0)\n" "$@"
}

# Ask for administrator password, and keep it alive in background
ask_admin_password() {
    # Ask for the administrator password upfront
    sudo -v
    # Keep-alive: update existing sudo time stamp if set, until current script has finished
    # This does not work with Homebrew, since it explicitly invalidates the sudo timestamp
    # See https://gist.github.com/cowboy/3118588
    while true; do sudo -n true; sleep 20; kill -0 "$$" || exit; done 2>/dev/null &
}

# Ask for confirmation before proceeding
ask_confirmation() {
    e_warning "$@"
    read -p "Continue? (y/n) " -n 1
    printf "\n"
}

# Ask for input
ask() {
    read -p "$@: "
}

# Test whether the result of a confirmation is positive or not
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]] ; then
      return 0
    fi
    return 1
}

# Get the last input form user
answer() {
    echo "$REPLY"
}

# Test whether the current shell is zsh
is_zsh_shell() {
    if [[ "$SHELL" =~ "zsh" ]] ; then
        return 0
    fi
    return 1
}

# Test whether the current zsh shell is the system default one
is_system_zsh_shell() {
    if [[ "$SHELL" = "/bin/zsh" ]] ; then
        return 0
    fi
    return 1   
}

# Test whether a command exists
# $1 - cmd to test
type_exists() {
    if [ $(type -p $1) ] ; then
        return 0
    fi
    return 1
}
