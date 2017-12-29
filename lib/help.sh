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

# Install MacOS updates
# Install Xcode tools
# Apply MacOS defaults
# Install brew
# Install git
# Install zsh
# Clone dotfiles repo
run_init() {
    # sudo -v
    # while true ; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    ## Setup ComputerName and HostName
    # TODO

    # Install MacOS Software
    e_header "Installing MacOS Software Updates..."
    ! softwareupdate --install --all --verbose

    # Install Xcode Command Line Tools
    e_header "Installing Xcode Command Line Tools..."
    ! xcode-select --install

    ## Apply MacOS Defaults for Developers
    # TODO

    # Install brew
    source "${DOTFILES_PATH}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_PATH}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_PATH}/lib/zsh/install.sh"

    # Setup the dotfiles repository, if missing
    if [[ ! -d "${DOTFILES_PATH}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_PATH}"
    fi
}

# Update dotfiles repo
# Symlink dotfiles
# Update zsh plugins
run_setup() {
    # Update the dotfiles repository
    if [[ ! -d "${DOTFILES_PATH}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_PATH}"
    else
        ask_confirmation "Updating dotfiles..."
        if is_confirmed ; then
            git -C "${DOTFILES_PATH}" pull --rebase origin "${DOTFILES_GIT_BRANCH}"
        fi
    fi

    # Symlink dotfiles into home folder
    e_header "Symlinking dotfiles..."
    for file in $(find -H "${DOTFILES_PATH}/lib" -maxdepth 2 -name "*.symlink") ; do
        ln -fs $file "${HOME}/.$(basename "${file%.*}")"
    done

    # Setup .localrc file into home folder
    if [[ ! -e "${HOME}/.localrc" ]] ; then
        e_header "Setting up .localrc file..."
        cp "${DOTFILES_PATH}/lib/localrc.example" "${HOME}/.localrc"
    fi

    # Apply changes immediately
    # source "${HOME}/.zshrc"
}
