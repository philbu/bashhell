alias cd1=random_directory


random_directory() {
	if [ "$1" == "" ]; then
		random_dir=$(find / -type d 2>/dev/null | shuf -n 1)
		cd $random_dir
	fi
	if [ "$1" == ".." ]; then
		cd /
	fi
}
