#!/bin/bash

# Clone or pull dotfiles repo
# Symlink dotfiles
# Source .zshrc and install zim modules
# Configure powerlevel10k
run_setup() {
    # Pull dotfiles repository
    update_dotfiles_repository

    # Symlink dotfiles into home folder
    e_header "Symlinking dotfiles..."
    for file in $(find -H "${DOTFILES_HOME}/lib" -maxdepth 2 -name "*.symlink") ; do
        ln -fs $file "${HOME}/.$(basename "${file%.*}")"
    done

    # Set up .zshrc.local file into home folder
    if ! file_exists "${HOME}/.zshrc.local" ; then
        e_header "Setting up ${HOME}/.zshrc.local file..."
        cp "${DOTFILES_HOME}/lib/zsh/zshrc.local" "${HOME}/.zshrc.local"
    fi

    # Install zim modules
    if [[ -s "${HOME}/.zshrc" ]] ; then
        e_header "Installing zim modules..."
        zsh -c 'source "${HOME}/.zshrc"'

         # Configure powerlevel10k
        if ! file_exists "${HOME}/.p10k.zsh" ; then
            e_header "Configuring powerlevel10k shell theme..."
            zsh -c 'source "${HOME}/.zshrc" && p10k configure'
        fi
    fi
}
