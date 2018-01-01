#!/bin/bash

# Install MacOS updates
# Install Xcode tools
# Install brew
# Install git
# Install zsh
# Clone dotfiles repo
run_init() {
    # TODO
    # https://github.com/donnemartin/dev-setup/blob/master/osxprep.sh
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L119
    # sudo -v
    # while true ; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    ## Setup ComputerName and HostName
    # TODO
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L126
    # https://github.com/bkuhlmann/mac_os-config/blob/master/bin/apply_basic_settings

    # Install MacOS Software
    e_header "Installing MacOS Software Updates..."
    ! softwareupdate --install --all --verbose

    # Install Xcode Command Line Tools
    e_header "Installing Xcode Command Line Tools..."
    # TODO
    # https://github.com/AndrewSB/dotfiles/blob/master/machine-setup-functions.sh#L9
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L307
    # https://github.com/ptb/mac-setup/blob/develop/mac-setup.command#L620
    ! xcode-select --install

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_HOME}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_HOME}/lib/zsh/install.sh"

    # Setup the dotfiles repository, if missing
    if [[ ! -d "${DOTFILES_HOME}/.git" ]] ; then
        e_header "Cloning dotfiles..."
        git clone -b "${DOTFILES_GIT_BRANCH}" "${DOTFILES_GIT_REMOTE}" "${DOTFILES_HOME}"
    fi
}
