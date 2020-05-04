#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

# git status variables
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}-> %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[cyan]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%} !"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} —"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%} »"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[white]%} #"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%} ?"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[yellow]%} $"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%} •|"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%} |•"

# git status display
local git_info='$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

# current user and hostname
local user_host='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[yellow]%}%m %{$reset_color%}'

# default: blue, if return code other than 0: red
local prompt_color="%(?,%{$fg[blue]%},%{$fg[red]%})"

# default: >
local prompt_symbol=">"

if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
    prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi

local prompt='${prompt_color}${prompt_symbol} %{$reset_color%}'

# current directory display
local directory_path='%{$fg[magenta]%}%c'

# last command return code
local return_code='%(?,,%{$fg[red]%} RC=%?%{$reset_color%})'

# set prompt style to multiline for users who have not yet updated .zshrc
if [ "$TYPEWRITTEN_MULTILINE" = true ]; then
    TYPEWRITTEN_PROMPT_LAYOUT="multiline"
fi

# set prompt style; default is singleline
if [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline" ]; then
    PROMPT="${prompt}"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline_verbose" ]; then
    PROMPT="${user_host}${prompt}"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "multiline" ]; then
    PROMPT="${user_host}
${prompt}"
else
    PROMPT="${prompt}"
fi

local right_prompt_prefix="%{$fg[white]%}"
if [ ! -z "$TYPEWRITTEN_RIGHT_PROMPT_PREFIX" ]; then
    right_prompt_prefix+="$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"
fi

# right prompt definition
RPROMPT="${right_prompt_prefix}${directory_path}"
RPROMPT+="${git_info}"
RPROMPT+="${return_code}"

# prompt cursor fix when exiting vim
local cursor="\e[3 q"
if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
  cursor="\e[1 q"
elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
  cursor="\e[5 q"
fi
_fix_cursor() {
  echo -ne "${cursor}"
}
precmd_functions+=(_fix_cursor)
