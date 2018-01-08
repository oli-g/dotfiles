#!/bin/bash

# Setup ComputerName and HostName
# Install brew apps (from ~/.Brewfile)
# Install cask apps (from ~/.Brewfile)
# Install AppStore apps (from ~/.Brewfile)
# Install other apps
# Configure apps
# Apply MacOS defaults
run_bootstrap() {
    ask_admin_password

    ask_confirmation "Setting up Computer name and Host name..."
    if is_confirmed ; then
        run_basic_setup
    fi

    # Install brew
    source "${DOTFILES_HOME}/lib/brew/install.sh"

    ask_confirmation "Installing packages and apps with Brew..."
    if is_confirmed ; then
        run_brew_bundle
    fi

    # source "${DOTFILES_HOME}/lib/sublime/install.sh"
    # source "${DOTFILES_HOME}/lib/vim/install.sh"
    # source "${DOTFILES_HOME}/lib/prezto/install.sh"
    # source "${DOTFILES_HOME}/lib/ruby/install.sh"
    # source "${DOTFILES_HOME}/lib/mysql/install.sh"
    # source "${DOTFILES_HOME}/lib/postgresql/install.sh"
    # source "${DOTFILES_HOME}/lib/go/install.sh"
    # source "${DOTFILES_HOME}/lib/docker/install.sh"
    # source "${DOTFILES_HOME}/lib/aws/install.sh"
    # source "${DOTFILES_HOME}/lib/heroku/install.sh"

    source "${DOTFILES_HOME}/lib/aws/install.sh"
    source "${DOTFILES_HOME}/lib/go/install.sh"
    source "${DOTFILES_HOME}/lib/iterm/install.sh"

    ask_confirmation "Applying MacOS Defaults for Developers..."
    if is_confirmed ; then
        apply_macos_defaults
    fi
}

run_basic_setup() {
    ## Setup ComputerName and HostName
    ask "Computer Name"
    computer_name=$(answer)
    ask "Host Name"
    host_name=$(answer)
    sudo scutil --set ComputerName "${computer_name}"
    sudo scutil --set HostName "${host_name}"
    sudo scutil --set LocalHostName "${host_name}"
    sudo defaults write "/Library/Preferences/SystemConfiguration/com.apple.smb.server" NetBIOSName -string "${host_name}"
}

run_brew_bundle() {
    if ! is_signed_in ; then
        e_warning "Please signin to the App Store..."
        open -a "/Applications/App Store.app"
        until is_signed_in ; do
            sleep 3
        done
    fi

    # Install global brew bundle apps
    ln -fs "${DOTFILES_HOME}/lib/Brewfile" "${HOME}/.Brewfile"
    e_header "Bundling from ${HOME}/.Brewfile..."
    brew bundle --global

    # Install local brew bundle apps
    if [[ -e "${HOME}/.Brewfile.local" ]] ; then
        e_header "Bundling from ${HOME}/.Brewfile.local..."
        brew bundle --file="${HOME}/.Brewfile.local"
    fi
}

apply_macos_defaults() {
    # Apply MacOS Defaults
    source "${DOTFILES_HOME}/bin/macos_apply_defaults"
}
