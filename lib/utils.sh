#!/bin/bash

# Header logging
e_header() {
    printf "$(tput setaf 7)%s$(tput sgr0)\n" "$@"
}

# Advice logging
e_advice() {
    printf "$(tput setaf 7)| %s$(tput sgr0)\n" "$@"
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
    sudo --validate
    # Keep-alive: update existing sudo time stamp if set, until current script has finished
    # This does not work with Homebrew, since it explicitly invalidates the sudo timestamp
    # See https://gist.github.com/cowboy/3118588
    while true; do sudo --non-interactiv true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
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

# Test whether a file exists
# $1 - file to test
file_exists() {
    if [[ -e $1 ]] ; then
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

is_command_line_tools_installed() {
    if softwareupdate --history | grep --silent "Command Line Tools" ; then
        return 0
    fi
    return 1
}

update_dotfiles_repository() {
    if [[ ! -d "${DOTFILES_HOME}/.git" ]] ; then
        e_header "Cloning dotfiles repository..."
        rm -rf "${DOTFILES_HOME}"
        git clone --branch "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_HOME}"
    else
        ask_confirmation "Pulling latest changes from remote dotfiles repository..."
        if is_confirmed ; then
            git -C "${DOTFILES_HOME}" pull --rebase origin "${DOTFILES_GIT_BRANCH}"
        fi
    fi
}

install_dotfiles() {
    # Clone or pull dotfiles repository
    update_dotfiles_repository

    # Symlink dotfiles into home folder
    e_header "Symlinking dotfiles..."
    for file in $(find -H "${DOTFILES_HOME}/lib" -maxdepth 2 -name "*.symlink") ; do
        ln -fs $file "${HOME}/.$(basename "${file%.*}")"
    done
}

# Test whether a Homebrew formula is already installed
# $1 - formula name
formula_exists() {
    if $(brew list "$1" >/dev/null) ; then
        printf "%s formula already installed.\n" "$1"
        return 0
    fi
    e_warning "Missing formula: $1"
    return 1
}

# Test whether a Homebrew tap is already installed
# $1 - tap name
tap_exists() {
    if $(brew tap | grep "$1" >/dev/null) ; then
        printf "%s tap already installed.\n" "$1"
        return 0
    fi
    e_warning "Missing tap: $1"
    return 1
}

is_signed_in() {
    if $(mas account >/dev/null) ; then
        e_header "Signed in as $(mas account)"
        return 0
    fi
    return 1
}
