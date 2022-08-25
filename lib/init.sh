#!/bin/bash

# Install MacOS Software Updates
# Install Xcode Command Line Tools
# Setup ComputerName and HostName
# Clone or pull dotfiles repo
# Symlink dotfiles
# Install brew
# Install git
# Install zsh
# Source .zshrc and install zim modules
# Configure powerlevel10k
run_init() {
    ask_admin_password

    # Install MacOS Software Updates
    ask_confirmation "Installing MacOS Software Updates..."
    if is_confirmed ; then
        softwareupdate --install --all --verbose
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
                e_header "Xcode Command Line Tools installation still running..."
                sleep 20
            fi
        done
    fi

    # Setup ComputerName and HostName
    ask_confirmation "Setting up Computer name and Host name..."
    if is_confirmed ; then
        run_basic_setup
    fi

    # Clone or pull dotfiles repository and install dotfiles
    install_dotfiles

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    # Install git
    source "${DOTFILES_HOME}/lib/git/install.sh"

    # Install zsh
    source "${DOTFILES_HOME}/lib/zsh/install.sh"

    e_advice "Please open a new terminal to get the latest changes..."
}

run_basic_setup() {
    ask "Computer Name"
    computer_name=$(answer)
    ask "Host Name"
    host_name=$(answer)

    sudo scutil --set ComputerName "${computer_name}"
    sudo scutil --set HostName "${host_name}"
    sudo scutil --set LocalHostName "${host_name}"
    sudo defaults write "/Library/Preferences/SystemConfiguration/com.apple.smb.server" NetBIOSName -string "${host_name}"
}
