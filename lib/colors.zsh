declare -Ag tw_color_mappings=(
  "foreground" "default"
  "primary" "magenta"
  "secondary" "blue"
  "notice" "yellow"
  "accent" "default"


  "info_positive" "green"
  "info_negative" "red"
  "info_neutral_1" "yellow"
  "info_neutral_2" "blue"
  "info_special" "cyan"
)

if [[ $TYPEWRITTEN_COLOR_MAPPINGS =~ ^[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+(\;[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+)*$ ]]; then
  tw_values=($(echo $TYPEWRITTEN_COLOR_MAPPINGS | tr ";" "\n"))
  for tw_value in $tw_values; do
    tw_value_definition=($(echo $tw_value | tr ":" "\n"))
    tw_color_mappings[$tw_value_definition[1]]=$tw_value_definition[2]
  done
elif [[ ! -z $TYPEWRITTEN_COLOR_MAPPINGS ]]; then
  echo "$TYPEWRITTEN_COLOR_MAPPINGS is not formatted correctly.
Format it like so: \"value:#009090;value:red\", etc."
fi

declare -Ag tw_colors=(
  "prompt" $tw_color_mappings[foreground]
  "current_directory" $tw_color_mappings[primary]
  "symbol" $tw_color_mappings[secondary]
  "symbol_root" $tw_color_mappings[notice]

  "arrow" $tw_color_mappings[accent]
  "right_prompt_prefix" $tw_color_mappings[accent]
  "virtual_env" $tw_color_mappings[accent]

  "symbol_error" $tw_color_mappings[info_negative]
  "error_code" $tw_color_mappings[info_negative]

  "host_user_connector" $tw_color_mappings[accent]
  "host" $tw_color_mappings[info_neutral_1]
  "user" $tw_color_mappings[info_neutral_1]

  "git_branch" $tw_color_mappings[primary]
  "git_rebasing" $tw_color_mappings[primary]
  "git_status_deleted" $tw_color_mappings[info_negative]
  "git_status_staged" $tw_color_mappings[info_positive]
  "git_status_stash" $tw_color_mappings[info_neutral_1]
  "git_status_modified" $tw_color_mappings[info_neutral_1]
  "git_status_new" $tw_color_mappings[info_neutral_2]
  "git_status_diverged" $tw_color_mappings[info_neutral_2]
  "git_status_ahead" $tw_color_mappings[info_neutral_2]
  "git_status_behind" $tw_color_mappings[info_neutral_2]
  "git_status_renamed" $tw_color_mappings[info_special]
  "git_status_unmerged" $tw_color_mappings[info_special]
)

if [[ $TYPEWRITTEN_COLORS =~ ^[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+(\;[#_0-9a-zA-Z]+:[#_0-9a-zA-Z]+)*$ ]]; then
  tw_values=($(echo $TYPEWRITTEN_COLORS | tr ";" "\n"))
  for tw_value in $tw_values; do
    tw_value_definition=($(echo $tw_value | tr ":" "\n"))
    tw_colors[$tw_value_definition[1]]=$tw_value_definition[2]
  done
elif [[ ! -z $TYPEWRITTEN_COLORS ]]; then
  echo "$TYPEWRITTEN_COLORS is not formatted correctly.
Format it like so: \"value:#009090;value:red\", etc."
fi
