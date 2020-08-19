# Prompt customization

Here lie all the options related to how or where the information is displayed on the prompt.

Click on an option's name to see more info.

| Option                                                                | Description                                                                                        | Available options                                                         | Default value |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------- |
| [TYPEWRITTEN_PROMPT_LAYOUT](#typewritten_prompt_layout)             | Defines how the prompt is displayed.                                                               | `singleline`, `half_pure` , `pure`, `singleline_verbose`, and `multiline` | `singleline`  |
| [TYPEWRITTEN_SYMBOL](#typewritten_symbol)                           | Defines the prompt symbol.                                                                         | Any string value                                                          | `>`           |
| [TYPEWRITTEN_GIT_RELATIVE_PATH](#typewritten_git_relative_path)     | If `true`, the current git home directory name is always shown next to the current directory name. | `true` or `false`                                                         | `false`       |
| [TYPEWRITTEN_CURSOR](#typewritten_cursor)                           | Defines the used cursor.                                                                           | `underscore`, `beam`, or `block`                                          | `underscore`  |
| [TYPEWRITTEN_RIGHT_PROMPT_PREFIX](#typewritten_right_prompt_prefix) | Defines what is displayed just before the right part of the prompt.                                | Any string                                                                |               |

> All of these options are configurable through your `.zshrc` file like this:
>
> ```shell
> export TYPEWRITTEN_PROMPT_LAYOUT="singleline"
> ```

## TYPEWRITTEN_PROMPT_LAYOUT

**Default single line (`TYPEWRITTEN_PROMPT_LAYOUT="singleline"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/layouts/singleline.png" alt="singleline prompt layout" />
</p>

**Half pure (`TYPEWRITTEN_PROMPT_LAYOUT="half_pure"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/layouts/half_pure.png" alt="half pure prompt layout" />
</p>

**[Pure](https://github.com/sindresorhus/pure) (`TYPEWRITTEN_PROMPT_LAYOUT="pure"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/layouts/pure.png" alt="pure prompt layout" />
</p>

**Single line - verbose variation (`TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/layouts/singleline_verbose.png" alt="single line verbose prompt layout" />
</p>

**Multiline (`TYPEWRITTEN_PROMPT_LAYOUT="multiline"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/layouts/multiline.png" alt="multiline prompt layout" />
</p>

## TYPEWRITTEN_SYMBOL

Here are some examples of customized prompt symbols.

**Default (`TYPEWRITTEN_SYMBOL="❯"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/symbols/default.png" alt="default symbol" />
</p>

**Dollar sign (`TYPEWRITTEN_SYMBOL="$"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/symbols/dollar_sign.png" alt="dollar sign symbol" />
</p>

**Full arrow (`TYPEWRITTEN_SYMBOL="->"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/symbols/arrow.png" alt="arrow symbol" />
</p>

## TYPEWRITTEN_GIT_RELATIVE_PATH

By default, the git root directory is always displayed no matter how far you are inside it.
To turn it off and display only the current directory, set `TYPEWRITTEN_GIT_RELATIVE_PATH` to `false`.

**Default behaviour (`TYPEWRITTEN_GIT_RELATIVE_PATH=true`)**

`/.../` is displayed when the nesting gets more than one level deep.

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/git_relative_path/git_relative_path.png" alt="default git relative path" />
</p>

**Hide git home directory (`TYPEWRITTEN_GIT_RELATIVE_PATH=false`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/git_relative_path/git_no_relative_path.png" alt="hide git home directory" />
</p>

## TYPEWRITTEN_CURSOR

**Default underscore (`TYPEWRITTEN_CURSOR="underscore"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/cursors/underscore.png" alt="underscore cursor" />
</p>

**Beam (`TYPEWRITTEN_CURSOR="beam"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/cursors/beam.png" alt="beam cursor" />
</p>

**Block (`TYPEWRITTEN_CURSOR="block"`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/cursors/block.png" alt="block cursor" />
</p>

## TYPEWRITTEN_RIGHT_PROMPT_PREFIX

**Bash comment prefix (`TYPEWRITTEN_RIGHT_PROMPT_PREFIX="# "`)**

<p align="center">
  <img src="https://raw.githubusercontent.com/reobin/typewritten/master/media/right_prompt_prefix.png" alt="bash comment prefix" />
</p>
