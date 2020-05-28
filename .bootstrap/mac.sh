#!/usr/bin/env bash

# Bootstraping script to setup a macbook after a fresh
# install and install user packages.

# Install the XCode tools, this gets things like python3.
xcode-select --install

# Install the hombrew package manager.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install packages.
brew install yadm tmux lastpass-cli cmake ninja macvim clang-format gpg base16 fd ffmpeg tldr

# Install precompiled macOS binaries (.app programs).
brew cask install firefox iterm2 virtualbox karabiner-elements hammerspoon ableton-live-standard musescore surge-synthesizer whatsapp vlc soulseek mactex

# Install fzf (TODO: Consider switching to the package on
# platforms that support it)
~/.fzf./install

# Install YCM (python 3.7 required and doesn't seem to be part of the XCode
# python installation)
pushd ~/.vim/pack/bundle/start/YouCompleteMe
git submodule update --init --recursive
brew install python3
./install.py --ninja --completer-clang
popd

# Select base16 color scheme.
base16_solarized-dark

# Change the default shell to zsh
chsh -s /bin/zsh
