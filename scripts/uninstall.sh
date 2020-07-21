DEST="/usr/local/share/zsh/site-functions"
DEST_TYPEWRITTEN="$DEST/prompt_typewritten_setup"
DEST_ASYNC="$DEST/async"

echo "Unlinking zsh prompt files...\n"
unlink "$DEST_TYPEWRITTEN"
unlink "$DEST_ASYNC"

echo "Done.\n"
echo "Don't forget to remove typewritten config lines in ~/.zshrc"
