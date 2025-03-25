#!/bin/bash

# Set up symlinks for dotfiles in the home directory

set -euo pipefail

# Beautiful output
print_success() { printf "\e[0;32m[✔] %s\e[0m\n" "$1"; }
print_error()   { printf "\e[0;31m[✖] %s\e[0m\n" "$1"; }
print_info()    { printf "\e[0;35m[➤] %s\e[0m\n" "$1"; }
ask() {
    printf "\e[0;33m[?] %s (Y/n): \e[0m" "$1"
    read -r REPLY
    if [ -z "$REPLY" ]; then
        REPLY="y"
    fi
}
answer_is_yes() { [[ "$REPLY" =~ ^[Yy]$ ]]; }

main() {
    print_info "Linking dotfiles to \$HOME..."

    # Find dotfiles in the current directory (excluding unnecessary ones)
    local dotfiles
    IFS=$'\n' read -r -d '' -a dotfiles < <(
        find . -maxdepth 1 -type f -name ".*" \
        ! -name ".DS_Store" \
        ! -name ".git" \
        ! -name ".gitignore" \
        ! -name ".macos" \
        ! -name "*.example" \
        | sort && printf '\0'
    )

    for src in "${dotfiles[@]}"; do
        local filename dest
        filename="$(basename "$src")"
        dest="$HOME/$filename"

        if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            ask "$dest already exists. Overwrite?"
            if answer_is_yes; then
                rm -rf "$dest"
                ln -s "$(pwd)/$filename" "$dest"
                print_success "Replaced $dest → $filename"
            else
                print_error "Skipped $dest"
            fi
        elif [ -L "$dest" ] && [ "$(readlink "$dest")" != "$(pwd)/$filename" ]; then
            ask "$dest is a symlink to a different file. Overwrite?"
            if answer_is_yes; then
                rm "$dest"
                ln -s "$(pwd)/$filename" "$dest"
                print_success "Updated $dest → $filename"
            else
                print_error "Skipped $dest"
            fi
        else
            ln -sf "$(pwd)/$filename" "$dest"
            print_success "Linked $dest → $filename"
        fi
    done
}

main