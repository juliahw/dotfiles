#!/usr/bin/env sh

# We wrap everything in parentheses to prevent the shell from executing only a prefix of the script
# if the download is interrupted and to prevent directory changes (`cd`) from persisting in the
# shell after the script has finished.
(
  rm -rf /tmp/dotfiles && \
  git clone --recurse-submodules https://github.com/juliahw/dotfiles.git /tmp/dotfiles && \
  cd /tmp/dotfiles && \
  ./install-local.sh && \
  rm -rf /tmp/dotfiles
)