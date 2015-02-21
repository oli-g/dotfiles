if ! formula_exists "git"; then
    e_header "Installing git..."
    brew install git
    if ! [ -e "${HOME}/.gitconfig" ]; then
        e_header "Setting up gitconfig file..."
        ask "Git author name"
        author_name=$(answer)
        ask "Git author email"
        author_email=$(answer)
        credentials_helper="osxkeychain"
        sed -e "s/AUTHOR_NAME/$author_name/g" \
            -e "s/AUTHOR_EMAIL/$author_email/g" \
            -e "s/CREDENTIALS_HELPER/$credentials_helper/g" \
            "${DOTFILES_PATH}/lib/git/gitconfig.symlink.example" > "${HOME}/.gitconfig"
    fi
else
    ask_confirmation "Updating git..."
    if is_confirmed; then
        brew upgrade git
    fi
fi