# Dotfiles

There are many dotfiles. These are mine.

## Features

TODO check https://github.com/necolas/dotfiles

## Install

For fist-time installation, run:

```
bash -c "$(curl -fsSL raw.github.com/oli-g/dotfiles/revamp/bin/dotfiles)" -- init
```

The command will install basic dependencies like Xcode Command Line Tools, Brew, Git and Zsh, and it will clone this repository into `$HOME/.dotfiles` folder.

In order to actually activate the dotfiles, run:

```
cd `$HOME/.dotfiles`
bin/dotfiles setup
```

The command will symlink a bunch of Zsh-related hidden files into `$HOME` folder. Open a new terminal session to see the changes.

## Update

After fist-time installation, dotfiles can be updated with the same `setup` subcommand:

```
dotfiles setup
```

In order to install and setup various software, run:

```
dotfiles bootstrap
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
