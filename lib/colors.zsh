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

declare -A color_mappings=(
  ["default"]="default"
  ["white"]="white"
  ["black"]="black"
  ["magenta"]="magenta"
  ["blue"]="blue"
  ["red"]="red"
  ["yellow"]="yellow"
  ["green"]="green"
  ["cyan"]="cyan"
)

_setup_custom_colors() {
  if [[ $TYPEWRITTEN_COLOR_MAPPINGS =~ ^[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+(\;[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+)*$ ]]; then
    values=($(echo $TYPEWRITTEN_COLOR_MAPPINGS | tr ";" "\n"))
    for value in $values; do
      value_definition=($(echo $value | tr ":" "\n"))
      color_mappings[$value_definition[1]]=$value_definition[2]
    done
  elif [[ ! -z $TYPEWRITTEN_COLOR_MAPPINGS ]]; then
    echo "$TYPEWRITTEN_COLOR_MAPPINGS is not formatted correctly.
Format it like so: \"value:#009090;value:red\", etc."
  fi

  if [[ $TYPEWRITTEN_COLORS =~ ^[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+(\;[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+)*$ ]]; then
    values=($(echo $TYPEWRITTEN_COLORS | tr ";" "\n"))
    for value in $values; do
      value_definition=($(echo $value | tr ":" "\n"))
      colors[$value_definition[1]]=$value_definition[2]
    done
  elif [[ ! -z $TYPEWRITTEN_COLORS ]]; then
    echo "$TYPEWRITTEN_COLORS is not formatted correctly.
Format it like so: \"value:#009090;value:red\", etc."
  fi

  # apply mapped colors
  for key value in ${(kv)colors}; do
    if [ ! -z $color_mappings[$value] ]; then
      colors[$key]=$color_mappings[$value]
    fi
  done
}

_setup_custom_colors
