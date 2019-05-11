#! /bin/sh

[[ -f /tmp/battwarn ]] && COUNT=$(cat /tmp/battwarn)

if [[ COUNT -ge 300 ]]; then
	COUNT=0
	[[ $(pacman -Qi zenity) ]] && zenity --warning --text "<span font_size='large' font_weight='bold'>Low battery</span>\n$BATT% of battery remaining" --title "Low battery warning" --width=150 &> /dev/null
fi

((COUNT++))

echo $COUNT > /tmp/battwarn
