declare -A colors=( ["prompt"]="blue" ["error"]="red")
custom_colors=($(echo $TYPEWRITTEN_COLORS | tr ";" "\n"))
for value in "${custom_colors[@]}"; do
  color_definition=($(echo $value | tr ":" "\n"))
  colors[$color_definition[1]]="$color_definition[2]"
done
