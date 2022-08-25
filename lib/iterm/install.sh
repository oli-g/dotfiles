#!/bin/bash

#
# https://iterm2colorschemes.com/
# https://github.com/mbadolato/iTerm2-Color-Schemes
# https://gist.github.com/ngs/ca7db8db427f2038f761
# https://ngs.io/2014/05/05/iterm2-color-schemes/

ITERM_SCHEMES_HOME="${HOME}/.config/iterm2/color-schemes"
ITERM_PLIST_NAME="com.googlecode.iterm2"
ITERM_PLIST_PATH="${HOME}/Library/Preferences/${ITERM_PLIST_NAME}.plist"

if [[ -e "${ITERM_PLIST_PATH}" ]] ; then
    ask_confirmation "Updating iTerm Theme..."
    if is_confirmed ; then
        mkdir -p "${ITERM_SCHEMES_HOME}"
        e_advice "Check available themes at http://iterm2colorschemes.com"
        ask "Theme Name" # Solarized Dark, SpaceGray, Dracula, Hipster Green
        theme_name=$(answer)
        theme_url="https://raw.github.com/mbadolato/iTerm2-Color-Schemes/master/schemes/$(echo "$theme_name" | sed 's/ /%20/g').itermcolors"
        theme_path="${ITERM_SCHEMES_HOME}/${theme_name}.itermcolors"
        curl -fsSLo "$theme_path" "$theme_url"
        defaults write -app iTerm 'Custom Color Presets' -dict-add "$theme_name" "$(cat "$theme_path")"
    fi
fi
