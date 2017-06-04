#!/usr/bin/env bash

# adapted from https://github.com/dracula/visual-studio-code/blob/master/bootstrap.sh

repo_dir="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"
vscode_dir=${VSCODE_DIR-~/.vscode}

attach() {
    sqs_theme_path="$( find $vscode_dir/extensions -maxdepth 1 -type d -name 'vscode-sqs-theme*' )"
    if [[ "$sqs_theme_path" ]]; then
        sqs_theme_dir="$( basename "$sqs_theme_path" )"
        mkdir -p "$vscode_dir"/extensions/disabled
        mv "$sqs_theme_path" "$vscode_dir"/extensions/disabled/"$sqs_theme_dir"
    fi
    ln -s "$repo_dir" "$vscode_dir"/extensions/vscode-sqs-theme
}

eject() {
    rm -f "$vscode_dir"/extensions/vscode-sqs-theme
    if [ -d "$vscode_dir"/extensions/disabled ]; then
        disabled_path="$( find $vscode_dir/extensions/disabled -maxdepth 1 -type d -name 'vscode-sqs-theme*' )"
        sqs_theme_dir="$( basename "$disabled_path" )"
        mv "$disabled_path" "$vscode_dir"/extensions/"$sqs_theme_dir"
        rm -r "$vscode_dir"/extensions/disabled
    fi
}

case "$1" in
    attach)
        attach
        ;;
    eject)
        eject
        ;;
esac