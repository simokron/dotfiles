#! /bin/sh

OLD=$(xdo id -n "scratchpad")

if [[ $OLD ]] ; then
	bspc node $OLD --flag locked=off
	xdo close $OLD
	rm /tmp/scratchid
fi

RES=$(xrandr | grep primary | cut -d " " -f 4)

if [[ $RES == '2560x1440+0+0' ]] ; then
	urxvt -name scratchpad -g 132x26+650-0 -e ~/dotfiles/scratchid.sh &
elif [[ $RES == '1920x1080+0+0' ]] ; then
	urxvt -name scratchpad -g 124x26+326-0 -e ~/dotfiles/scratchid.sh &
fi
