#!/bin/bash

# Install MacOS Software Updates
# Install Xcode Command Line Tools
# Clone or pull dotfiles repo
# Install brew
# Install git
# Install zsh
run_init() {
    ask_admin_password

    # Install MacOS Software Updates
    ask_confirmation "Installing MacOS Software Updates..."
    if is_cofirmed ; then
        sudo softwareupdate --install --all --verbose
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
        while true ; do
            if is_command_line_tools_installed ; then
                e_success "Xcode Command Line Tools installed correctly"
                break
            else
                e_header "Xcode Command Line Tools still installing..."
                sleep 20
            fi
        done
    fi

    # Clone or pull dotfiles repository
    update_dotfiles_repository

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_HOME}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_HOME}/lib/zsh/install.sh"
}
