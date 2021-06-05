#!/usr/bin/env bash
#
#  Repro.sh
#  Copyright (c) 2021 Adam Sidialicherif
#
#  A bash script for making bash scripts
#  See https://repro.sh/docs/ for usage documentation.
#
#

function init {
	mkdir ~/.repro/scripts
	touch ~/.repro/aliases
	touch ~/.repro/config
	source ~/.repro/aliases
}

function save {
	# Globals
	storageLocation=~/.repro/scripts/
	# check for correct history log by shell
	hist=~/.zsh_history && [[ "$SHELL" == "/bin/bash" ]] && hist=~/.bash_history
	count=$(($1+1)) # actual index of commands to store, including tail offset
	filename=$2 # name of script

	# check for config and global overrides
	if [[ -f ~/.repro/config ]]; then
		source ~/.repro/config
		[[ ! -d $storageLocation ]] && mkdir -p $storageLocation
	else
		init
	fi

	finalFile=$storageLocation/$filename.sh

	# start the new script
	echo '#!/usr/bin/env bash' > $finalFile

	# Get commands to add to script
	tail -$count $hist >> $finalFile

	# remove the tail command above from the script
	awk -v n=1 'NR>n{print line[NR%n]};{line[NR%n]=$0}' $finalFile > $finalFile.tmp && mv $finalFile{.tmp,}

	# remove the zsh prefixes from the history lines
	sed "s/^.*;//g" $finalFile > $finalFile.tmp && mv $finalFile{.tmp,}

	# grant executable perm to file
	chmod +x $finalFile

	# add script to aliases
	echo "alias $filename=\"$finalFile\"" >> ~/.repro/aliases
	source ~/.repro/aliases

	echo "Script $filename.sh created"
}

function reset {
	echo "Are you sure you want to reset? This will permanently erase all scripts. (Yes/no)"
	read conf
	if [[ "$conf" == "Yes" ]]; then
		rm -rf ~/.repro/scripts
		rm ~/.repro/aliases
		rm ~/.repro/config
		init
		echo "Done."
	fi
}

function list {
	echo "Available scripts:"
	echo "---"
	for listing in ~/.repro/scripts/*
	do
		echo " - " $(basename $listing)
	done
}


cmd=$1

# Run command
[[ "$cmd" == "save" ]] && save $2 $3
[[ "$cmd" == "init" ]] && init
[[ "$cmd" == "reset" ]] && reset
[[ "$cmd" == "list" ]] && list
