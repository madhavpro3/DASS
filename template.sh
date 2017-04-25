#! /bin/bash
# Welcome to DASS
# Requires festival, ap-hotspot

# Global Variables.
CUR_DIR=""
EDU_DIR="/home/madhav/D/sem\ 7/"
OFIS=$IFS
SYS_NAME="DASS"


# Functions
location() {
	printf "Sir, I am currently at $CUR_DIR\n"
}
speak(){
	printf "Speaking....\n"
	echo $1 | festival --tts
}
enter_studying () {
	# List the available course dirs
	i=0
	IFS=:
	for dir in $EDU_DIR*/
	do 
	contents[i]=$dir
	(( i++ )) 
	done
	# if there are any then display them
	if [ ${#contents[@]} -gt 1 ]
	then
		speak "I have these courses with me sir"
		j=0
		for course in ${contents[@]}
		do 
			printf $j":"$course"\n"
			(( j++ ))
		done
		read cmd
		CUR_DIR=${contents[$cmd]}
		location

		main_func
	else
	speak "U have not fed me with any courses sir"
	fi

	IFS=$OFIS

}
start_hotspot () {
	if [[ $(whoami) -eq "root" ]]
	then
		ap-hotspot start
	else
		speak "Sir, please give me permissions of a root user"
	fi
}
stop_hotspot () {
	if [[ $(whoami) -eq "root" ]]
	then
		ap-hotspot stop
	else
		speak "Sir, please give me permissions of a root user"
	fi

}
open_dir () {
	#Give information on current positin
	location

	# List the available directories
	echo Sir I have these with me now | festival --tts
	i=0
	for file in /home/madhav/*/
	do 
	contents[i]=$file
	(( i++ )) 
	done
	# if there are any then display them
	if [ ${#contents[@]} -gt 1 ]
	then
		j=0
		for i in ${contents[@]}
		do 
			printf $j":"$i"\n"
			(( j++ ))
		done
		read cmd
		cd ${contents[$cmd]}		
	else
	speak "there are no directories here sir"
	fi

	location
}
play_music(){
	printf "Playing.....\n"
	rhythmbox /home/madhav/madhav/music/Aye_Khuda-_HindiMp3.Mobi_.mp3 &
}
open_gmail(){
	firefox www.mail.google.com
}
open_facebook(){
	firefox www.facebook.com
}
say_name(){
	speak "Sir I am $SYS_NAME"
}
check_battery(){
	temp=$(acpi -b)
	temp=${temp#*,}
	temp=${temp%,*}
	battery=${temp%%%}

	if [ $battery -lt 10 ]
		then
		speak "Sir I need to be charged"
	fi
	# ans3=${ans3%%%}
}

 
main_func(){
	clear
	# echo "Welcome Sir. What do u want to do"
	cat resources/mad.txt
	printf "1: Open a directory 2: Play Music 3: I want to study\n4: Start Hotspot 5: Stop Hotspot\n6: Open Gmail 7: Open Facebook\n" 
	printf "8: Who are U ?\n"
	read action
	if [ $action -eq 1 ]
	then
		open_dir
	elif [[ $action -eq 2 ]]
		then
		play_music
	 elif [[ $action -eq 3 ]]
		then
		enter_studying
	 elif [[ $action -eq 4 ]]
		then
		start_hotspot
	 elif [[ $action -eq 5 ]]
	 	then
	 	stop_hotspot
	 elif [[ $action -eq 6 ]]
	 	then
	 	open_gmail
	 elif [[ $action -eq 7 ]]
	 	then
	 	open_facebook
	 elif [[ $action -eq 8 ]]
	 	then
	 	say_name
	 else 
	 	speak "Work in progress sir"
	fi
	main_func
}

# Look for battery status every 300sec (5min)
	# while true
	# do
	# 	sleep 300
	# 	check_battery
	# done


clear
speak "Welcome Madhav What do u want to do"
main_func





