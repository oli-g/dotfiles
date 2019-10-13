#!/bin/bash

# Install MacOS updates
# Install Xcode tools
# Install brew
# Install git
# Install zsh
# Clone dotfiles repo
run_init() {
    ask_admin_password

    # Install MacOS Software Updates
    ask_confirmation "Installing MacOS Software Updates..."
    if is_confirmed ; then
        ! softwareupdate --install --all --verbose
    fi

    # Install Xcode Command Line Tools
    # TODO
    # https://github.com/AndrewSB/dotfiles/blob/master/machine-setup-functions.sh#L9
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L307
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L620
    # sudo xcodebuild -license accept
    ask_confirmation "Installing Xcode Command Line Tools..."
    if is_confirmed ; then
        ! xcode-select --install
    fi

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_HOME}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_HOME}/lib/zsh/install.sh"

    # Setup the dotfiles repository, if missing
    if [[ ! -d "${DOTFILES_HOME}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        rm -rf "${DOTFILES_HOME}"
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_HOME}"
    fi
}
