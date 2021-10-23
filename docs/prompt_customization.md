# Prompt customization

Here lie all the options related to how or where the information is displayed on the prompt.

Click on an option's name to see more info.

| Option                                                              | Description                                                         | Available options                                                         | Default value |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------- |
| [TYPEWRITTEN_PROMPT_LAYOUT](#typewritten_prompt_layout)             | Defines how the prompt is displayed.                                | `singleline`, `half_pure` , `pure`, `singleline_verbose`, and `multiline` | `singleline`  |
| [TYPEWRITTEN_SYMBOL](#typewritten_symbol)                           | Defines the prompt symbol.                                          | Any string value                                                          | `❯`           |
| [TYPEWRITTEN_ARROW_SYMBOL](#typewritten_arrow_symbol)               | Defines the arrow symbol.                                           | Any string value                                                          | `->`          |
| [TYPEWRITTEN_RELATIVE_PATH](#typewritten_relative_path)             | Defines what the current directory display is relative to.          | `git`, `home`, `adaptive`, or `off`                                       | `git`         |
| [TYPEWRITTEN_CURSOR](#typewritten_cursor)                           | Defines the used cursor.                                            | `underscore`, `beam`, `block`, or `terminal`                              | `underscore`  |
| [TYPEWRITTEN_RIGHT_PROMPT_PREFIX](#typewritten_right_prompt_prefix) | Defines what is displayed just before the right part of the prompt. | Any string                                                                |               |

> All of these options are configurable through your `.zshrc` file like this:
>
> ```shell
> export TYPEWRITTEN_PROMPT_LAYOUT="singleline"
> ```

## TYPEWRITTEN_PROMPT_LAYOUT

**Default single line (`TYPEWRITTEN_PROMPT_LAYOUT="singleline"`)**

<p align="center">
  <img src="_media/layouts/singleline.png" alt="singleline prompt layout" />
</p>

**Half pure (`TYPEWRITTEN_PROMPT_LAYOUT="half_pure"`)**

<p align="center">
  <img src="_media/layouts/half_pure.png" alt="half pure prompt layout" />
</p>

**[Pure](https://github.com/sindresorhus/pure) (`TYPEWRITTEN_PROMPT_LAYOUT="pure"`)**

<p align="center">
  <img src="_media/layouts/pure.png" alt="pure prompt layout" />
</p>

**Pure - verbose variation (`TYPEWRITTEN_PROMPT_LAYOUT="pure_verbose"`)**

<p align="center">
  <img src="_media/layouts/pure_verbose.png" alt="pure verbose prompt layout" />
</p>

**Single line - verbose variation (`TYPEWRITTEN_PROMPT_LAYOUT="singleline_verbose"`)**

<p align="center">
  <img src="_media/layouts/singleline_verbose.png" alt="single line verbose prompt layout" />
</p>

**Multiline (`TYPEWRITTEN_PROMPT_LAYOUT="multiline"`)**

<p align="center">
  <img src="_media/layouts/multiline.png" alt="multiline prompt layout" />
</p>

## TYPEWRITTEN_SYMBOL

Here are some examples of customized prompt symbols.

**Default (`TYPEWRITTEN_SYMBOL="❯"`)**

<p align="center">
  <img src="_media/symbols/default.png" alt="default symbol" />
</p>

**Dollar sign (`TYPEWRITTEN_SYMBOL="$"`)**

<p align="center">
  <img src="_media/symbols/dollar_sign.png" alt="dollar sign symbol" />
</p>

**Full arrow (`TYPEWRITTEN_SYMBOL="->"`)**

<p align="center">
  <img src="_media/symbols/arrow.png" alt="arrow symbol" />
</p>

## TYPEWRITTEN_ARROW_SYMBOL

Here are some examples of customized prompt arrow symbols.

**Default (`TYPEWRITTEN_ARROW_SYMBOL="->"`)**

<p align="center">
  <img src="_media/arrow_symbols/default.png" alt="default arrow symbol" />
</p>

**Glyph arrow (`TYPEWRITTEN_ARROW_SYMBOL="➜"`)**

<p align="center">
  <img src="_media/arrow_symbols/glyph_arrow.png" alt="glyph arrow symbol" />
</p>

## TYPEWRITTEN_RELATIVE_PATH

By default, when in a git repository, the git root directory is always displayed no matter how far you are inside it.

**Default behaviour (`TYPEWRITTEN_RELATIVE_PATH="git"`)**

`/.../` is displayed when the nesting gets more than one level deep.

<p align="center">
  <img src="_media/git_relative_path/git_relative_path.png" alt="default git relative path" />
</p>

When outside of a git repository, only the basename of the current directory is displayed.

<p align="center">
 <img src="_media/relative_path_off.png" alt="relative path off" />
</p>

**Relative to `$HOME` (`TYPEWRITTEN_RELATIVE_PATH="home"`)**

When set to `home`, the full directory path relative to `$HOME` is displayed at all times.

<p align="center">
  <img src="_media/home_relative_path.png" alt="display path relative to home" />
</p>

**Adaptive (`git` and `home`) (`TYPEWRITTEN_RELATIVE_PATH="adaptive"`)**

Adaptive display means that if you are in a git repository, the current directory will show the current path relative to the git root directory.

<p align="center">
  <img src="_media/git_relative_path/git_relative_path.png" alt="default git relative path" />
</p>

If you are outside of a git repository, the path will be displayed relative to `$HOME`.

<p align="center">
  <img src="_media/adaptive_home_relative_path.png" alt="display path relative to home" />
</p>

**Off (`TYPEWRITTEN_RELATIVE_PATH="off"`)**

This option being off means that at all times, the current directory display only shows the basename of the current directory.

<p align="center">
  <img src="_media/git_relative_path/git_no_relative_path.png" alt="hide git home directory" />
</p>

## TYPEWRITTEN_CURSOR

**Default underscore (`TYPEWRITTEN_CURSOR="underscore"`)**

<p align="center">
  <img src="_media/cursors/underscore.png" alt="underscore cursor" />
</p>

**Beam (`TYPEWRITTEN_CURSOR="beam"`)**

<p align="center">
  <img src="_media/cursors/beam.png" alt="beam cursor" />
</p>

**Block (`TYPEWRITTEN_CURSOR="block"`)**

<p align="center">
  <img src="_media/cursors/block.png" alt="block cursor" />
</p>

**Terminal (`TYPEWRITTEN_CURSOR="terminal"`)**

By using this option, typewritten stops managing cursor preference. The cursor used will be the one configured by your terminal emulator.

## TYPEWRITTEN_RIGHT_PROMPT_PREFIX

**Bash comment prefix (`TYPEWRITTEN_RIGHT_PROMPT_PREFIX="# "`)**

<p align="center">
  <img src="_media/right_prompt_prefix.png" alt="bash comment prefix" />
</p>
