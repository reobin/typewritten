#!/usr/bin/env zsh
#
# Author: Denys Dovhan, denysdovhan.com
# https://github.com/spaceship-prompt/spaceship-prompt

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
USER_SOURCE="${ZDOTDIR:-$HOME}/.typewritten-prompt"

PROMPT_SETUP="prompt_typewritten_setup"
PROMPT_ASYNC="async"

GLOBAL_DEST_SETUP="/usr/local/share/zsh/site-functions/$PROMPT_SETUP"
USER_DEST_SETUP="${ZDOTDIR:-$HOME}/.zfunctions/$PROMPT_SETUP"

GLOBAL_DEST_ASYNC="/usr/local/share/zsh/site-functions/$PROMPT_ASYNC"
USER_DEST_ASYNC="${ZDOTDIR:-$HOME}/.zfunctions/$PROMPT_ASYNC"

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
info()    { paint "$cyan"   "Typewritten: $@" ; }
warn()    { paint "$yellow" "Typewritten: $@" ; }
error()   { paint "$red"    "Typewritten: $@" ; }
success() { paint "$green"  "Typewritten: $@" ; }
code()    { paint "$bold"   "Typewritten: $@" ; }

# Check if symlink is exists and remove it
# USAGE:
#   rmln <target>
rmln() {
  local target=$1
  if [[ -L "$target" ]]; then
    info "Removing $target..."
    rm -f "$target"
  fi
}

# ------------------------------------------------------------------------------
# MAIN
# Checkings and uninstalling process
# ------------------------------------------------------------------------------

main() {
  # Remove prompt setup symlink
  if [[ -L "$GLOBAL_DEST_SETUP" || -L "$USER_DEST_SETUP" ]]; then
    rmln "$GLOBAL_DEST_SETUP"
    rmln "$USER_DEST_SETUP"
  else
    warn "Symlinks to Typewritten setup are not found."
  fi

  # Remove prompt async symlink
  if [[ -L "$GLOBAL_DEST_ASYNC" || -L "$USER_DEST_ASYNC" ]]; then
    rmln "$GLOBAL_DEST_ASYNC"
    rmln "$USER_DEST_ASYNC"
  else
    warn "Symlinks to Typewritten async are not found."
  fi

  success "Done! Typewritten installation has been removed!"
  info "Don't forget to remove Typewritten config lines in ~/.zshrc"
  success "Please, reload your terminal."
}

main "$@"
