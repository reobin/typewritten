declare -A color_mappings=(
  ["foreground"]="default"

  ["primary"]="magenta"
  ["secondary"]="blue"

  ["accent"]="default"

  ["info_positive"]="green"
  ["info_negative"]="red"

  ["info_neutral_1"]="yellow"
  ["info_neutral_2"]="blue"

  ["info_special"]="cyan"
)

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

declare -A colors=(
  ["prompt"]=$color_mappings[foreground]

  ["current_directory"]=$color_mappings[primary]
  ["git_branch"]=$color_mappings[primary]
  ["git_rebasing"]=$color_mappings[primary]

  ["symbol"]=$color_mappings[secondary]

  ["arrow"]=$color_mappings[accent]
  ["host_user_connector"]=$color_mappings[accent]
  ["right_prompt_prefix"]=$color_mappings[accent]

  ["symbol_error"]=$color_mappings[info_negative]
  ["error_code"]=$color_mappings[info_negative]
  ["git_status_deleted"]=$color_mappings[info_negative]

  ["git_status_staged"]=$color_mappings[info_positive]

  ["host"]=$color_mappings[info_neutral_1]
  ["user"]=$color_mappings[info_neutral_1]
  ["virtualenv"]=$color_mappings[info_neutral_1]
  ["git_status_stash"]=$color_mappings[info_neutral_1]
  ["git_status_modified"]=$color_mappings[info_neutral_1]

  ["git_status_new"]=$color_mappings[info_neutral_2]
  ["git_status_diverged"]=$color_mappings[info_neutral_2]
  ["git_status_ahead"]=$color_mappings[info_neutral_2]
  ["git_status_behind"]=$color_mappings[info_neutral_2]

  ["git_status_renamed"]=$color_mappings[info_special]
  ["git_status_unmerged"]=$color_mappings[info_special]
)

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
