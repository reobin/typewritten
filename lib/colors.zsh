declare -A colors=(
  ["symbol"]="blue"
  ["symbol_error"]="red"
  ["error_code"]="red"
  ["current_directory"]="magenta"
  ["right_prompt_prefix"]="default"
  ["host"]="yellow"
  ["host_user_connector"]="default"
  ["user"]="yellow"
  ["prompt"]="default"
  ["virtualenv"]="default"
  ["git_branch"]="magenta"
  ["arrow"]="default"
  ["git_rebasing"]="magenta"
  ["git_status_staged"]="green"
  ["git_status_new"]="blue"
  ["git_status_modified"]="yellow"
  ["git_status_renamed"]="cyan"
  ["git_status_deleted"]="red"
  ["git_status_unmerged"]="default"
  ["git_status_diverged"]="blue"
  ["git_status_ahead"]="blue"
  ["git_status_behind"]="blue"
  ["git_status_stash"]="yellow"
)

_setup_custom_colors() {
  if [[ $TYPEWRITTEN_COLORS =~ ^[a-z_]+:[a-z_]+(\;[a-z_]+:[a-z_]+)*$ ]]; then
    custom_colors=($(echo $TYPEWRITTEN_COLORS | tr ";" "\n"))
    for value in "${custom_colors[@]}"; do
      color_definition=($(echo $value | tr ":" "\n"))
      colors[$color_definition[1]]="$color_definition[2]"
    done
  else
    echo "TYPEWRITTEN_COLORS is not formatted correctly.
Format it like so: \"prompt:red;symbol:blue\", etc."
  fi
}

_setup_custom_colors
