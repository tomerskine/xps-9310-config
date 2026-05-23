#!/bin/bash
# Install oh-my-zsh if not already present.
# KEEP_ZSHRC=yes prevents the installer from overwriting our managed .zshrc.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    KEEP_ZSHRC=yes RUNZSH=no \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
