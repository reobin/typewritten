#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

# git status variables
ZSH_THEME_GIT_PROMPT_PREFIX=" -> %{$fg[magenta]%}"
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

# current directory display
local directory_path='%{$fg[magenta]%}%c%{$reset_color%}'

# last command return code
local return_code='%(?,,%{$fg[red]%} RC=%?%{$reset_color%})'

# default: >
local prompt_symbol=">"

if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
    prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi

local prompt='${prompt_color}${prompt_symbol} %{$reset_color%}'

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

function _set_right_prompt () {
    local right_prompt_prefix="%{$fg[white]%}"
    if [ ! -z "$TYPEWRITTEN_RIGHT_PROMPT_PREFIX" ]; then
        right_prompt_prefix+="$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"
    fi

    RPROMPT="${right_prompt_prefix}"
    local git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"
    local git_root=""
    if [ "$TYPEWRITTEN_GIT_RELATIVE_PATH" = true -a "$git_hide_status" != "1" ]; then
        local repo_path=`git rev-parse --show-toplevel` > /dev/null 2>&1
        local current_directory=`pwd`
        if [ "${repo_path}" != "" -a "${repo_path}" != "${current_directory}" ]; then
            local repo_name=`basename ${repo_path}`
            git_root="$repo_name"
        fi;
    fi;
    if [ "${git_root}" != "" ]; then
        # check how many directories are between
        current_nesting=${current_directory//[^\/]}
        repo_nesting=${repo_path//[^\/]}
        diff=`expr ${#current_nesting} - ${#repo_nesting}`
        if [ $diff -eq 1 ]; then
            RPROMPT+="%{$fg[magenta]%}${git_root}/"
        else
            RPROMPT+="%{$fg[magenta]%}${git_root}/.../"
        fi;
    fi;
    RPROMPT+="${directory_path}"
    if [ "$git_hide_status" != "1" ]; then
        RPROMPT+="${git_info}"
    fi
    RPROMPT+="${return_code}"
}

_fix_cursor() {
    # prompt cursor fix when exiting vim
    local cursor="\e[3 q"
    if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
        cursor="\e[1 q"
    elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
        cursor="\e[5 q"
    fi
    echo -ne "${cursor}"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _fix_cursor
add-zsh-hook precmd _set_right_prompt
