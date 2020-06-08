#      ____ ____ ____ ____ ____ ____ ____ ____ ____ ____ ____
#     ||t |||y |||p |||e |||w |||r |||i |||t |||t |||e |||n ||
#     ||__|||__|||__|||__|||__|||__|||__|||__|||__|||__|||__||
#     |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
#             A minimal, informative zsh prompt theme
#

# default: blue, if return code other than 0: red
local t_prompt_color="%(?,%F{blue},%F{red})"
local t_prompt_symbol=">"

if [ ! -z "$TYPEWRITTEN_SYMBOL" ]; then
    t_prompt_symbol="$TYPEWRITTEN_SYMBOL"
fi

local t_prompt="$t_prompt_color$t_prompt_symbol %F{default}"

# current user and hostname
local t_user_host="%F{yellow}%n%F{default}@%F{yellow}%m "

# set prompt style to multiline for users who have not yet updated .zshrc
if [ "$TYPEWRITTEN_MULTILINE" = true ]; then
    TYPEWRITTEN_PROMPT_LAYOUT="multiline"
fi
# set prompt style; default is singleline
if [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline" ]; then
    PROMPT="$t_prompt"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "singleline_verbose" ]; then
    PROMPT="$t_user_host$t_prompt"
elif [ "$TYPEWRITTEN_PROMPT_LAYOUT" = "multiline" ]; then
    PROMPT="$t_user_host
$t_prompt"
else
    PROMPT="$t_prompt"
fi

function t_git_branch() {
    branch_name="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
    if [ "$branch_name" != "" ]; then
        echo " -> $branch_name"
    else
        echo ""
    fi
}

# current directory display
function _set_right_prompt () {
    local t_directory_path="%c"
    local t_return_code="%(?,,%F{red} RC=%?)"

    local t_right_prompt_prefix="%F{default}"
    if [ ! -z "$TYPEWRITTEN_RIGHT_PROMPT_PREFIX" ]; then
        right_prompt_prefix+="$TYPEWRITTEN_RIGHT_PROMPT_PREFIX"
    fi
    RPROMPT="${t_right_prompt_prefix}"

    local git_hide_status="$(git config --get oh-my-zsh.hide-status 2>/dev/null)"

    local git_root=""
    if [ "$TYPEWRITTEN_GIT_RELATIVE_PATH" = true -a "$git_hide_status" != "1" ]; then
        local repo_path="$(git rev-parse --show-toplevel)" > /dev/null 2>&1
        local current_directory="$(pwd)"
        if [ "$repo_path" != "" -a "$repo_path" != "$current_directory" ]; then
            local repo_name=`basename $repo_path`
            git_root="$repo_name"
        fi;
    fi;
    if [ "$git_root" != "" ]; then
        # check how many directories are between
        local current_nesting="${current_directory//[^\/]}"
        local repo_nesting="${repo_path//[^\/]}"
        local diff=`expr ${#current_nesting} - ${#repo_nesting}`
        if [ $diff -eq 1 ]; then
            RPROMPT+="$git_root/"
        else
            RPROMPT+="$git_root/.../"
        fi;
    fi;

    RPROMPT+="$t_directory_path"
    if [ "$git_hide_status" != "1" ]; then
        RPROMPT+="$(t_git_branch)"
        # RPTOMPT+="$(t_git_status)"
    fi
    RPROMPT+="$t_return_code"
}

_fix_cursor() {
    # prompt cursor fix when exiting vim
    local t_cursor="\e[3 q"
    if [ "$TYPEWRITTEN_CURSOR" = "block" ]; then
        t_cursor="\e[1 q"
    elif [ "$TYPEWRITTEN_CURSOR" = "beam" ]; then
        t_cursor="\e[5 q"
    fi
    echo -ne "$t_cursor"
}

autoload -U add-zsh-hook
add-zsh-hook precmd _fix_cursor
add-zsh-hook precmd _set_right_prompt

zle_highlight=( default:fg=default )
