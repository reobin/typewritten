# ``>_`` typewritten - a minimal, informative zsh prompt theme

Leaves all the room for what's important.
<p align="center">
  <img src="./media/typewritten-demo.gif?raw=true" width="100%" alt="Demo" />
</p>

> Terminal is [iTerm2](https://iterm2.com/) — Font is [JetBrains Mono](https://www.jetbrains.com/lp/mono/) — Terminal theme is [SpaceCamp](https://github.com/reobin/spacecamp-iterm)


## Features
- Current directory
- Current git branch
- [git status indicators](#git-status-indicators)
- [Return code](#return-code)
- [Various customization options](#customization-options)
  - [Prompt layout](#typewritten_prompt_layout)
  - [Prompt symbol](#typewritten_symbol)
  - [Constant display of git home directory](#typewritten_git_relative_path)
  - [Cursor](#typewritten_cursor)
  - [Prefix on right prompt](#typewritten_right_prompt_prefix)


## Installation
Clone the repository into your custom oh-my-zsh themes directory:
```shell
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```

Symlink ``typewritten.zsh-theme`` to your oh-my-zsh custom themes directory:
```shell
ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
```

Set ``ZSH_THEME="typewritten"`` in your ``.zshrc`` file.


## Customization options

Click on an option's name to see more info.

| Option | Description | Available options | Default value |
|---|---|---|---|
| [`TYPEWRITTEN_PROMPT_LAYOUT`](#typewritten_prompt_layout) | Defines how the prompt is displayed. | `singleline`, `singleline_verbose`, and `multiline` | `singleline` |
| [`TYPEWRITTEN_SYMBOL`](#typewritten_symbol) | Defines the prompt symbol. | Any string value | `>` |
| [`TYPEWRITTEN_GIT_RELATIVE_PATH`](#typewritten_git_relative_path) | If `true`, the current git home directory name is always shown next to the current directory name. | `true` or `false` | `false` |
| [`TYPEWRITTEN_CURSOR`](#typewritten_cursor) | Defines the used cursor. | `underscore`, `beam`, or `block` | `underscore` |
| [`TYPEWRITTEN_RIGHT_PROMPT_PREFIX`](#typewritten_right_prompt_prefix) | Defines what is displayed just before the right part of the prompt. | Any string | |


### `TYPEWRITTEN_PROMPT_LAYOUT`

**Default single line (`TYPEWRITTEN_PROMPT_LAYOUT="singleline"`)**
<p align="center">
  <img src="/media/prompt_layout/default.png" alt="singleline prompt layout" />
</p>

**Single line - verbose variation (`TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"`)**
<p align="center">
  <img src="/media/prompt_layout/singleline_verbose.png" alt="single line verbose prompt layout" />
</p>

**Multiline (`TYPEWRITTEN_PROMPT_LAYOUT="multiline"`)**
<p align="center">
  <img src="/media/prompt_layout/multiline.png" alt="multiline prompt layout" />
</p>


### `TYPEWRITTEN_SYMBOL`

Here are some examples of customized prompt symbols.

**Default arrow (`TYPEWRITTEN_SYMBOL=">"`)**
<p align="center">
  <img src="/media/prompt_symbol/default.png" alt="default symbol" />
</p>

**Octothorp (`TYPEWRITTEN_SYMBOL="#"`)**
<p align="center">
  <img src="/media/prompt_symbol/hashtag.png" alt="octothorp symbol" />
</p>

**Full arrow (`TYPEWRITTEN_SYMBOL="->"`)**
<p align="center">
  <img src="/media/prompt_symbol/arrow.png" alt="arrow symbol" />
</p>

**Dollar sign (`TYPEWRITTEN_SYMBOL="$"`)**
<p align="center">
  <img src="/media/prompt_symbol/dollar_sign.png" alt="dollar_sign symbol" />
</p>


### `TYPEWRITTEN_GIT_RELATIVE_PATH`

By default, only the current working directory is displayed on the right. The `TYPEWRITTEN_GIT_RELATIVE_PATH` option can be turned on to display the git root directory as well as the current working directory:

**Default behaviour (`TYPEWRITTEN_GIT_RELATIVE_PATH=false`)**
<p align="center">
  <img src="/media/git_root_relative_path/off.png" alt="default path" />
</p>

**Show git home direcoty (`TYPEWRITTEN_GIT_RELATIVE_PATH=true`)**

`/.../` is displayed when the nesting gets more than one level deep.
<p align="center">
  <img src="/media/git_root_relative_path/on.png" alt="show git home directory" />
</p>


### `TYPEWRITTEN_CURSOR`

**Default underscore (`TYPEWRITTEN_CURSOR="underscore"`)**
<p align="center">
  <img src="/media/cursor/underscore.png" alt="underscore cursor" />
</p>

**Beam (`TYPEWRITTEN_CURSOR="beam"`)**

<p align="center">
  <img src="/media/cursor/beam.png" alt="beam cursor" />
</p>

**Block (`TYPEWRITTEN_CURSOR="block"`)**
<p align="center">
  <img src="/media/cursor/block.png" alt="block cursor" />
</p>


### `TYPEWRITTEN_RIGHT_PROMPT_PREFIX`

**Default no prefix (`TYPEWRITTEN_RIGHT_PROMPT_PREFIX=""`)**
<p align="center">
  <img src="/media/right_prompt_prefix/none.png" alt="no right prompt prefix" />
</p>

**Bash comment prefix (`TYPEWRITTEN_RIGHT_PROMPT_PREFIX="# "`)**
<p align="center">
  <img src="/media/right_prompt_prefix/hash_tag.png" alt="bash comment prefix" />
</p>


## More info

### git status indicators
- ``?``     &nbsp; — untracked change(s);
- ``+``     &nbsp; — staged change(s);
- ``!``     &nbsp; — file(s) modified in the repo;
- ``»``     &nbsp; — renamed file(s);
- ``—``     &nbsp; — deleted file(s);
- ``$``     &nbsp; — stashed change(s);
- ``#``     &nbsp; — unmerged change(s);
- ``•|``    — behind of remote branch;
- ``|•``    — ahead of remote branch;

Git status can be disabled by setting `git config` value in a repo or globally like so:

```bash
git config --add oh-my-zsh.hide-status 1
```

### return code
When an error happens, the prompt symbol changed to a red color, and the return code is displayed on the right.
<p align="center">
  <img src="/media/return_code/127.png" alt="127 return code" />
</p>


## Contributors
* [@thbe](https://github.com/thbe)
* [@erikr](https://github.com/erikr)
* [@artem-zinnatullin](https://github.com/artem-zinnatullin)
