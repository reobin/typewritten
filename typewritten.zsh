#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

export TYPEWRITTEN_ROOT=${${(%):-%x}:A:h}
source "$TYPEWRITTEN_ROOT/lib/git.zsh"

# default: blue, if return code other than 0: red
local prompt_color="%(?,%F{blue},%F{red})"

local prompt_symbol=">"
if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
    prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi

local typewritten_prompt="$prompt_color$prompt_symbol %F{default}"

# current user and hostname
local user_host="%F{yellow}%n%F{default}@%F{yellow}%m "

# set prompt style to multiline for users who have not yet updated .zshrc
if [ "$TYPEWRITTEN_MULTILINE" = true ]; then
    TYPEWRITTEN_PROMPT_LAYOUT="multiline"
fi
# set prompt style; default is singleline
if [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline" ]; then
    PROMPT="$typewritten_prompt"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline_verbose" ]; then
    PROMPT="$user_host$typewritten_prompt"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "multiline" ]; then
    PROMPT="$user_host
$typewritten_prompt"
else
    PROMPT="$typewritten_prompt"
fi

# current directory display
_set_right_prompt() {
    local directory_path="%c"
    local return_code="%(?,,%F{red} RC=%?)"

    local right_prompt_prefix="%F{default}"
    if [ ! -z "$TYPEWRITTEN_RIGHT_PROMPT_PREFIX" ]; then
        right_prompt_prefix+="$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"
    fi
    RPROMPT="${right_prompt_prefix}"

    local git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"

    local git_home_display=""
    local git_branch=""
    local git_status=""

    if [[ "$git_hide_status" != "1" ]] && [[ $(typewritten_is_git_repository) == true ]]; then
      git_branch="$(typewritten_git_branch)"
      git_status="$(typewritten_git_status)"

      if [ "$TYPEWRITTEN_GIT_RELATIVE_PATH" != false ]; then
        git_home_display="$(typewritten_git_home_display)"
      fi
    fi

    RPROMPT+="%F{magenta}$git_home_display$directory_path"
    RPROMPT+="$git_branch"
    RPROMPT+="$git_status"
    RPROMPT+="$return_code"
}

_fix_cursor() {
    # prompt cursor fix when exiting vim
    local cursor="\e[3 q"
    if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
        cursor="\e[1 q"
    elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
        cursor="\e[5 q"
    fi
    echo -ne "$cursor"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _fix_cursor
add-zsh-hook precmd _set_right_prompt

zle_highlight=( default:fg=default )
