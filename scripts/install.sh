#!/usr/bin/env zsh
#
# This script is a clone/fork of the spaceship-prompt install script and it was
# changed in order to install the typewritten prompt instead.
#
# Original author: Denys Dovhan, denysdovhan.com
# From: https://github.com/spaceship-prompt/spaceship-prompt

# ------------------------------------------------------------------------------
# Colors
# Set color variables for colorful output
# ------------------------------------------------------------------------------

# If we have tput, let's set colors
if [[ ! -z $(which tput 2> /dev/null) ]]; then
  reset=$(tput sgr0)
  bold=$(tput bold)
  red=$(tput setaf 1)
  green=$(tput setaf 2)
  yellow=$(tput setaf 3)
  blue=$(tput setaf 4)
  magenta=$(tput setaf 5)
  cyan=$(tput setaf 6)
fi

# ------------------------------------------------------------------------------
# VARIABLES
# Paths to important resources
# ------------------------------------------------------------------------------

ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
REPO='https://github.com/reobin/typewritten.git'

SOURCE="$PWD/typewritten.zsh"
ASYNC_SOURCE="$PWD/async.zsh"
USER_SOURCE="${ZDOTDIR:-$HOME}/.typewritten-prompt"

DEST='/usr/local/share/zsh/site-functions'
USER_DEST="${ZDOTDIR:-$HOME}/.zfunctions"

# ------------------------------------------------------------------------------
# HELPERS
# Useful functions for common tasks
# ------------------------------------------------------------------------------

# Paint text in specific color with reset
# USAGE:
#   paint <color> [text...]
paint() {
  local color=$1 rest=${@:2}
  echo "$color$rest$reset"
}

# Aliases for common used colors
# Colon at the end is required: https://askubuntu.com/a/521942
# USAGE:
#   info|warn|error|success|code [...text]
info()    { paint "$cyan"   "typewritten: $@" ; }
warn()    { paint "$yellow" "typewritten: $@" ; }
error()   { paint "$red"    "typewritten: $@" ; }
success() { paint "$green"  "typewritten: $@" ; }
code()    { paint "$bold"   "typewritten: $@" ; }

# Append text in .zshrc
# USAGE:
#   append_zshrc [text...]
append_zshrc() {
  info "These lines will be added to your \"${ZDOTDIR:-$HOME}/.zshrc\" file:"
  code "$@"
  echo "$@" >> "${ZDOTDIR:-$HOME}/.zshrc"
}

# ------------------------------------------------------------------------------
# MAIN
# Checkings and installing process
# ------------------------------------------------------------------------------

main() {
  # How we install typewritten:
  #   1. Install via NPM
  #   2. Install via curl or wget
  if [[ ! -f "$SOURCE" ]]; then
    warn "typewritten is not present in current directory"
    # Clone repo into the ${ZDOTDIR:-$HOME}/.typewritten-prompt and change SOURCE
    git clone "$REPO" "$USER_SOURCE"
    SOURCE="$USER_SOURCE/typewritten.zsh"
    ASYNC_SOURCE="$USER_SOURCE/async.zsh"
  else
    info "typewritten is present in current directory"
  fi

  # If we can't symlink to the site-functions, then try to use .zfunctions instead
  if [[ ! -w "$DEST" ]]; then
    error "Failed to symlink $SOURCE to $DEST."
    error "Failed to symlink $ASYNC_SOURCE to $DEST."

    # Use $USER_DEST instead
    DEST="$USER_DEST"

    info "Adding $DEST to fpath..."
    echo 'fpath=($fpath "'"$DEST"'")' >> "$ZSHRC"

    info "Trying to symlink $SOURCE to $DEST"
    info "Trying to symlink $ASYNC_SOURCE to $DEST"
  fi

  # Link prompt entry point to fpath
  info "Linking $SOURCE to $DEST/prompt_typewritten_setup..."
  info "Linking $ASYNC_SOURCE to $DEST/async..."
  mkdir -p "$DEST"
  ln -sf "$SOURCE" "$DEST/prompt_typewritten_setup"
  ln -sf "$ASYNC_SOURCE" "$DEST/async"

  # If 'prompt typewritten' is already present in .zshrc, then skip
  if sed 's/#.*//' "$ZSHRC" | grep -q "prompt typewritten"; then
    warn "typewritten is already present in .zshrc!"
    exit
  fi

  # Enabling statements for .zshrc
  msg="\n# Set typewritten ZSH as a prompt"
  msg+="\nautoload -U promptinit; promptinit"
  msg+="\nprompt typewritten"

  # Check if appending was successful and perform corresponding actions
  if append_zshrc "$msg"; then
    success "Done! Please, reload your terminal."
    echo
  else
    error "Cannot automatically insert prompt init commands."
    error "Please insert these line into your \"${ZDOTDIR:-$HOME}/.zshrc\" file:"
    code "$msg"
    exit 1
  fi
}

main "$@"
