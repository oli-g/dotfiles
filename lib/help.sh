#!/bin/bash

run_help() {

    cat <<EOT
OS X dotfiles - Giannicola Olivadoti - http://oli-g.me/
Usage: $(basename "$0") [options]
Options:
    -h, --help      Print this help text
    -l, --list      Print a list of additional software to install
    --no-packages   Suppress package updates
    --no-sync       Suppress pulling from the remote repository
Documentation can be found at https://github.com/oli-g/dotfiles/
Copyright (c) Giannicola Olivadoti
Licensed under the MIT license.
EOT

}

# Install xcode tools
# Install brew
# Apply osx defaults
run_init() {
    ## Setup ComputerName and HostName
    # TODO

    # Install MacOS Software
    e_header "Installing MacOS Software Updates..."
    # ! softwareupdate --install --all --verbose

    # Install Xcode Command Line Tools
    e_header "Installing Xcode Command Line Tools..."
    # ! xcode-select --install

    ## Setup MacOS Defaults for Developers
    # TODO

    # Install brew
    source "${DOTFILES_PATH}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_PATH}/lib/git/install.sh"

    # Setup the dotfiles repository, if missing
    if [[ ! -d "${DOTFILES_PATH}/.git" ]] ; then
        e_header "Cloning dotfiles Repository..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_PATH}"
    fi
}
