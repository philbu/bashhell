#!/bin/bash

alias cd1=hell_cd
alias ls1=hell_ls
alias nano1=hell_nano
alias exec1=hell_exec
alias echo1=hell_echo
alias touch1=hell_touch
alias mv1=hell_mv

hell_ls() {
	args="$@"
	ls --color $args | sort -R
}

hell_exec() {
	if [ "$1" == "bash" ]; then
		echo "You cannot escape hell without a path."
	else
		exec "$@"
	fi
}

hell_nano() {
	if [ -x "$(command -v nano)" ]; then
		if [ -x "$(command -v vim)" ]; then
			vim "$@"
		elif [ -x "$(command -v emacs)" ]; then
			emacs "$@"
		else
			nano "$@"
		fi
	fi
}

hell_cd() {
	if [ "$1" == "" ]; then
		random_dir=$(find / -type d 2>/dev/null | shuf -n 1)
		cd $random_dir
		return 0
	fi
	cd_path=$1
	if [[ "$cd_path" == ..* ]]; then
		# This obviously breaks autocomplete
		cd $(random "$cd_path" "${cd_path/../../..}" "3")
	else
		cd $(random "/" "$cd_path" "4")
	fi
}

hell_echo() {
	str=$@
	if [ "$str" == "" ]; then
		echo "*silence*"
		return 0
	fi
	str=${str^^[a,e,i,o,u]}
	str=${str,,[B,C,D,F,G,H,J,K,L,M,N,P,Q,R,S,T,V,W,X,Y,Z]}
	echo $str
}

hell_touch() {
	filename=$1
	if [ "$filename" == "" ]; then
		echo "You must specify a file name."
		return 0
	fi
	mkdir -p .files && touch .files/"${filename}"
}

hell_mv() {
	arr=( "$@" )
	declare -a exts
	declare -a randarr

	for arg in "${arr[@]}"; do
		filename="${arg##*/}"

		count=$(echo "$filename" | grep -o "\." | wc -l)
		if [ "$count" -gt 0 ]; then
			exts=("${filename#*.}" "${exts[@]}")
		fi		
	done

	if [ "${exts[0]}" == "${exts[1]}" ]; then
		filename_dst="${arr[1]##*/}"
		dst_name="${filename_dst%%.*}"

		dir=$(dirname "${arr[1]}")
		files=($dir/*."${exts[1]}")

		filename_src="${arr[0]##*/}"
		if [[ ! "${files[@]}" =~ "$filename_src" ]]; then
			echo "File '$filename_src' not in directory '$dir'."
			return 0
		fi

		count=$(ls "$dir"/*."${exts[1]}" | wc -l)

		readarray randarr < <(seq "$count" | shuf)		

		echo ${randarr[@]}
		echo ${files[@]}
		for ((i=0;i<count;i++)); do
			filename="${files[i]}"

			mv "$filename" "${dst_name}${randarr[i]%?}"."${exts[1]}"
		done	
	else
		echo "Try to mv to a file with same extension."
		return 0
	fi
	
}

random(){
	low_prob_text=$1
	high_prob_text=$2
	x=$3
	if [ "$low_prob_text" == "" ] || [ "$high_prob_text" == "" ]; then
		return 0
	fi
	if [ "$x" == "" ]; then
		x=10
	fi
	random_number=$(( RANDOM % $x ))
	if [ "$random_number" == "0" ]; then
		echo -n "$low_prob_text"
	else
		echo -n "$high_prob_text"
	fi
}
LS_COLORS='rs=0:di=01;91;41:ln=01;37;100:*=0;34;104';
export LS_COLORS
