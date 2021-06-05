# Repro.sh
#### Automatically create and manage scripts from history

[![asciicast](https://asciinema.org/a/418471.svg)](https://asciinema.org/a/418471)

## Why?

You're working on a new (or old) project, reading some documentation. There's a series of bash commands presented to you to execute sequentially, such as installing and configuring dependencies for a new tool. As you copy and paste these commands one by one into your terminal and hit enter, you think to yourself, "I should really just turn this into a script." You consider it momentarily, until you say "I'll just do it next time I'm doing this, I'm busy right now." Until next time comes, and the cycle repeats.

With Repro, after you're done working with a new set of commands, you can save and enable them as a new script with just one command, so you'll never have to re-read the tutorial steps or retype the commands manually ever again.

### Why not just use `history`?

- the `history` util has different functionality between different shells (try `history 5` in `zsh`, you'll get an untruncated list of commands. `bash` will truncate to the last 5). 
- `history` has unnecessarily confusing syntax
- the lifespan of a command in history is too short if you haven't typed something in a while, or you end up searching through your massive history file
- `history` doesn't give you a way to categorize and organize sets of commands as scripts

## Getting Started

### Pre-requisites

Repro.sh currently requires a compatible shell. We are working in expanding shell support. Here are the currently compatible shells:

- `bash`
- `zsh`

Repro also requires that your shell history be enabled, as it ingests your shell history file to determine script contents.

### Installation

Run the following command in your terminal to install Repro:

```
git clone git@github.com:asidiali/repro.git ~/.repro/
```

You can then add Repro alias to your desired shell profile. For example, for your `.zsh_profile` or `.zshrc` file:

```
echo "alias repro=\"~/.repro/repro.sh\"" >> .zshrc && source .zshrc
```

You should now be able to use the `repro` command in your terminal. You can try this out with `repro -v`, which should return the current Repro.sh version installed.

### Usage

