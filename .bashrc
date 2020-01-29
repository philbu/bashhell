#!/bin/bash

alias cd1=hell_cd
alias ls1=hell_ls
alias nano1=hell_nano
alias exec1=hell_exec
alias echo1=hell_echo
alias touch1=hell_touch

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
