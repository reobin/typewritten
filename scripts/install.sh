SOURCE="$PWD"
DEST="/usr/local/share/zsh/site-functions"

SOURCE_TYPEWRITTEN="$SOURCE/typewritten.zsh"
DEST_TYPEWRITTEN="$DEST/prompt_typewritten_setup"

SOURCE_ASYNC="$SOURCE/async.zsh"
DEST_ASYNC="$DEST/async"

ZSHRC="$HOME/.zshrc"

echo "Installing typewritten...\n"

mkdir -p "$DEST"

link() {
  local source="$1"
  local dest="$2"
  if [ -f "$dest" ]; then
    echo "Unlinking $dest"
    rm "$dest"
  fi
  echo "Linking $source -> $dest\n"
  ln -sf "$source" "$dest"
}

link "$SOURCE_TYPEWRITTEN" "$DEST_TYPEWRITTEN"
link "$SOURCE_ASYNC" "$DEST_ASYNC"

echo "Setting up zsh prompt..."
if sed "s/#.*//" "$ZSHRC" | grep -q "prompt typewritten"; then
  echo "typewritten is already present in .zshrc!\n"
  echo "Reload zsh."
  exit
fi

config="\n# Set typewritten ZSH as a prompt"
config+="\nautoload -U promptinit; promptinit"
config+="\nprompt typewritten"
echo "$config" >> "$ZSHRC"

echo "Done.\n"
echo "Reload zsh.\n"

exit
