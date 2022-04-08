# Installation

## npm

```shell
npm install -g typewritten
```

That's it. The script will make the necessary symlinks to `fpath` and set the prompt in your `.zshrc`.

## Manual

Clone the typewritten repository somewhere you can easily link. I recommend creating a `.zsh` directory at root.

```shell
mkdir -p "$HOME/.zsh"
git clone https://github.com/reobin/typewritten.git "$HOME/.zsh/typewritten"
```

Load typewritten in your `.zshrc` by using zsh prompinit:

```shell
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten
```

Note: if using `oh-my-zsh`, set `ZSH_THEME=""` in your `.zshrc` to disable oh-my-zsh themes.

## oh-my-zsh

Clone the repository into your custom oh-my-zsh themes directory:

```shell
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```

Symlink `typewritten.zsh-theme` to your oh-my-zsh custom themes directory:

```shell
ln -s "$ZSH_CUSTOM/themes/typewritten/typewritten.zsh-theme" "$ZSH_CUSTOM/themes/typewritten.zsh-theme"
ln -s "$ZSH_CUSTOM/themes/typewritten/async.zsh" "$ZSH_CUSTOM/themes/async"
```

Set `ZSH_THEME="typewritten"` in your `.zshrc` file.

Note: If creating the symlinks is a problem, you can skip the step and set `ZSH_THEME="typewritten/typewritten"` instead.

## antibody

Add `antibody bundle reobin/typewritten` to your `.zshrc`.

## antigen

Add `antigen bundle reobin/typewritten@main` to your `.zshrc`.

## zgen

Add `zgen load reobin/typewritten typewritten` to your `.zshrc`.

## zim

Add `zmodule reobin/typewritten --name typewritten` to your `.zimrc` and run `zimfw install`.

## zplug

Add `zplug reobin/typewritten, as:theme` to your `.zshrc`.
