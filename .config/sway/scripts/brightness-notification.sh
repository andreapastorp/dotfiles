#!/bin/bash

get_brightness()
{
	brightness=$(brightnessctl get)
	echo $brightness
}

notify_user()
{
	notify-send -h string:x-canonical-private-synchronous:sys-notify "  $(get_brightness)%" -h "int:value:$(get_brightness)"
}

case $1 in
	increase)
		brightnessctl set +5
		notify_user
		;;

	decrease)
		brightnessctl set 5-
		notify_user
		;;
esac
