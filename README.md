# Dotfiles

There are many dotfiles. These are mine.

## Features

TODO check https://github.com/necolas/dotfiles

## Install

For fist-time installation, run:

```bash
bash -c "$(curl -fsSL raw.github.com/oli-g/dotfiles/master/bin/dotfiles)" -- init
```

The command will install MacOS Software Updates and basic dependencies like Xcode Command Line Tools, `brew`, `git` and `zsh`, then it will clone this repository into `$HOME/.dotfiles` folder. The command will symlink a bunch of hidden files (related to `zsh`, `git` and more) into `$HOME` folder. Open a new terminal session to see the changes.

The same command can be re-run multiple times after first installation with:

```bash
dotfiles setup
```

## Update

After fist-time installation, dotfiles and various software can be updated with the `update` subcommand:

```bash
dotfiles update
```

## Inspiration

* https://github.com/mathiasbynens/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/cowboy/dotfiles
* https://github.com/necolas/dotfiles
* https://github.com/matijs/dotfiles
* https://github.com/skwp/dotfiles
* https://github.com/AndrewSB/dotfiles
* https://github.com/hql287/dotfiles
* https://github.com/ptb/mac-setup
* https://github.com/donnemartin/dev-setup
* https://github.com/bkuhlmann/mac_os
* https://github.com/bkuhlmann/mac_os-config

## License

TODO https://github.com/bkuhlmann/mac_os-config#license

Copyright (c) 2018 Giannicola Olivadoti
Licensed under the MIT license
