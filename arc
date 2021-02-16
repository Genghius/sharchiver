#!/bin/sh

usage(){
	printf "Usage: arc [archive|extract] [archive] [files]... |[destdir]|\n"
	exit 1
}

archive(){
	shift

	[ "$1" ] || usage

	case $1 in
		*.tar.xz|*.tar.bz2)
			cmd="tar cjf $1 ";;
		*.tgz|*.tar.gz)
			cmd="tar czf $1 ";;
		*.tbz2)
			cmd="tar cvjSF $1 ";;
		*.tar)
			cmd="tar cvf $1 ";;
		*.Z|*.zip)
			cmd="zip $1 ";;
		*.7z)
			cmd="7z a $1 ";;
		*)
			printf "\"$1\" Is not a recognized archive format.\n";;
	esac

	while [ "$2" ]; do
		shift
		cmd="$cmd $1"
	done
	
	$cmd
}

extract(){
	shift

	[ "$1" ] || usage

	case $1 in
		*.tbz2|*.tar.bz2)
			o="-C"
			cmd="tar xjf $1 ";;
		*.tgz|*.tar.gz)
			o="-C"
			cmd="tar xzf $1 ";;
		*.tar.xz)
			o="-C"
			cmd="tar -xf $1 ";;
		*.tar)
			o="-C"
			cmd="tar xf $1 ";;
		*.zip)
			o="-d"
			cmd="unzip $1 ";;
		*.7z)
			o="-o"
			cmd="7z x $1 ";;
		*.Z)
			o="-d"
			cmd="unzip $1 ";;
		*)
			printf "\"$1\" Is not a recognized archive format.\n";;
	esac

	[ -d "$2" ] && cmd="$cmd $o $2"

	$cmd
}

if [ "$1" = "archive" ]; then
	archive $@
elif [ "$1" = "extract" ]; then
	extract $@
else
	usage
fi
