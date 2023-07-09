
# $1: env file
export_env () {
	while IFS= read -r line
	do
		export $(echo $line)
	done < "$1"
}

export_env "$1"
