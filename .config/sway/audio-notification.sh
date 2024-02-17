#!/bin/bash

get_volume()
{
	volume=$(pamixer --get-volume)
	echo $volume
}

notify_user()
{
	notify-send -h string:x-canonical-private-synchronous:sys-notify "Volume: $(get_volume)%" -h "int:value:$(get_volume)"
}

case $1 in
	increase)
		pamixer -u
		pamixer -i 5
		notify_user
		;;

	decrease)
		pamixer -u
		pamixer -d 5
		notify_user
		;;

	mute)
		pamixer -t
		notify-send "Mute" 
		;;

esac
