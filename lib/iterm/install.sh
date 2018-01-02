#!/bin/bash

ITERM_SCHEMES_HOME="${HOME}/.iTerm/schemes"
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

        ! /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'$theme_name' dict" "${ITERM_PLIST_PATH}"
        ! /usr/libexec/PlistBuddy -c "Merge '$theme_path' :'Custom Color Presets':'$theme_name'" "${ITERM_PLIST_PATH}"

        declare -a colors=("Ansi 0 Color" "Ansi 1 Color" "Ansi 2 Color" "Ansi 3 Color" "Ansi 4 Color" "Ansi 5 Color" "Ansi 6 Color" "Ansi 7 Color"
                            "Ansi 8 Color" "Ansi 9 Color" "Ansi 10 Color" "Ansi 11 Color" "Ansi 12 Color" "Ansi 13 Color" "Ansi 14 Color" "Ansi 15 Color"
                            "Background Color" "Bold Color" "Cursor Color" "Cursor Text Color" "Foreground Color" "Selected Text Color" "Selection Color")
        for col in "${colors[@]}" ; do
            /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':0:'$col'" "${ITERM_PLIST_PATH}"
        done
        /usr/libexec/PlistBuddy -c "Merge '$theme_path' :'New Bookmarks':0" "${ITERM_PLIST_PATH}"
    fi
fi
